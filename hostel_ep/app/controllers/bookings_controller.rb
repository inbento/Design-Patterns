class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking, notice: 'Бронирование успешно создано.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Бронирование успешно обновлено.'
    else
      render :edit
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_url, notice: 'Бронирование успешно удалено.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:client_id, :room_id, :service_id, :check_in_date, :departure_date)
  end
end