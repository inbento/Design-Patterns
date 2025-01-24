# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @bookings = Booking.includes(:client, :room, :service).all
  end
  def disconnect
    ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: 'invalid_host')
    redirect_to root_path, notice: 'Соединение с базой данных разорвано.'
  end
end