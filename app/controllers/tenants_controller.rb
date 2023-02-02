class TenantsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, includes: [:apartment]
    end

    def create
        new_tenant = Tenant.create!(tenant_params)
        render json: new_tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def record_not_found
        render json: { errors: "tenant not found" }, status: :not_found
    end

end
