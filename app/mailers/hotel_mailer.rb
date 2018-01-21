class HotelMailer < ApplicationMailer
  default from: 'l104514@lhr.nu.edu.pk'
  layout 'mailer'

  def guest_email(user, hotel, table, reservation )
    @email_data = {hotel: hotel, reservation: reservation, table: table}
    @user = user
    mail(to: @user.email, subject: "Reservation successfully Made for #{@user.name}")
  end

  def hotel_email(guest, hotel, table, reservation )
    @email_data = {hotel: hotel, reservation: reservation, table: table, guest: guest}
    mail(to: hotel.email, subject: "Reservation successfully Made for #{guest.name}")
  end

  def updated_hotel_email(user, options)
    @options= options
    mail(to: user.email, subject: "Rservation Has been Updated")
  end
end
