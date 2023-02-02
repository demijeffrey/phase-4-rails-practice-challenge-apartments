class ApartmentsController < ApplicationController

rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def create
        new_apartment = Apartment.create!(apartment_params)
        render json: new_apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def record_not_found
        render json: { error: "apartment not found" }, status: :not_found
    end

end
