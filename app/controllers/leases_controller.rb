class LeasesController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


    def create
        new_lease = Lease.create!(lease_params)
        render json: new_lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def record_not_found
        render json: { error: "lease not found" }, status: :not_found
    end

end
