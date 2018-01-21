module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :set_reservation, only: [:show, :update, :destroy]

      # GET /reservations
      def index
        @reservations = Reservation.includes(:hotel, :table, :guest).all.collect { |res| [res.res_time, res.hotel.name, res.table.name, res.guest.name, res.guest_count] }

        render json: @reservations
      end

      # GET /reservations/1
      def show
        render json: @reservation
      end

      # POST /reservations
      def create
        @reservation = Reservation.new(reservation_params)
        hotel = Hotel.find_by(id: params[:reservation][:hotel_id])
        guest = Guest.from_hotel(hotel.try(:id)).find_by(id: params[:reservation][:guest_id])
        table = Table.from_hotel(hotel.try(:id)).find_by(id: params[:reservation][:table_id])
        res_time = params[:reservation][:res_time]

        if check_conditions(table, hotel, res_time, guest)
          if @reservation.save
            HotelMailer.guest_email(guest, hotel, table, @reservation).deliver
            HotelMailer.hotel_email(guest, hotel, table, @reservation).deliver
            render json: @reservation, status: :created, location: api_v1_reservations_url
          else
            render json: @reservation.errors, status: :unprocessable_entity
          end
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /reservations/1
      def update
        hotel = Hotel.find_by(id: params[:reservation][:hotel_id])
        guest = Guest.from_hotel(hotel.try(:id)).find_by(id: params[:reservation][:guest_id])
        table = Table.from_hotel(hotel.try(:id)).find_by(id: params[:reservation][:table_id])
        res_time = params[:reservation][:res_time]

        if check_conditions(table, hotel, res_time, guest)
          @reservation.attributes = reservation_params
          if @reservation.changed?
             HotelMailer.updated_hotel_email(guest, @reservation.changes).deliver
          end
          if @reservation.save
            render json: @reservation
          else
            render json: @reservation.errors, status: :unprocessable_entity
          end
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
      end

      # DELETE /reservations/1
      def destroy
        @reservation.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end
      def check_conditions(table, hotel, res_time, guest)
        table && guest && hotel && (Time.parse(res_time).strftime("%H:%M:%S") < (hotel.end_time).strftime("%H:%M:%S")) && (Time.parse(res_time).strftime("%H:%M:%S") > (hotel.start_time).strftime("%H:%M:%S")) &&
            (params[:reservation][:guest_count] > table.minimum_guest && params[:reservation][:guest_count] < table.maximum_guest )
      end
      # Only allow a trusted parameter "white list" through.
      def reservation_params
        params.require(:reservation).permit(:res_time, :hotel_id, :guest_id, :table_id, :guest_count)
      end
    end
  end
end
