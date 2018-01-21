module Api
  module V1
    class HotelsController < ApplicationController
      before_action :set_hotel, only: [:show, :update]

      # GET /hotels
      def index
        @hotels = Hotel.all

        render json: @hotels
      end

      # GET /hotels/1
      def show
        render json: @hotel
      end

      # POST /hotels
      def create
        @hotel = Hotel.new(hotel_params)

        if @hotel.save
          render json: @hotel, status: :created, location: api_v1_hotels_url
        else
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /hotels/1
      def update
        if @hotel.update(hotel_params)
          render json: @hotel
        else
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_hotel
        @hotel = Hotel.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def hotel_params
        params.require(:hotel).permit(:name, :phone, :email, :start_time, :end_time)
      end
    end
  end
end
