module Api
  module V1
    class GuestsController < ApplicationController
      before_action :set_guest, only: [:show, :destroy, :update]

      # GET /guests
      def index
        @guests = Guest.all

        render json: @guests
      end

      # GET /guests/1
      def show
        render json: @guest
      end

      # POST /guests
      def create
        @guest = Guest.new(guest_params)

        if @guest.save
          render json: @guest, status: :created, location: api_v1_guests_url
        else
          render json: @guest.errors, status: :unprocessable_entity
        end
      end

      def update
        if @guest.update(guest_params)
          render json: @guest
        else
          render json: @guest.errors, status: :unprocessable_entity
        end
      end


      private
      # Use callbacks to share common setup or constraints between actions.
      def set_guest
        @guest = Guest.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def guest_params
        params.require(:guest).permit(:name, :email, :hotel_id)
      end
    end
  end
end
