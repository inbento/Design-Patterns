class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::ConnectionNotEstablished, PG::ConnectionBad, with: :handle_database_connection_error
  
  private
  
  def handle_database_connection_error(exception)
    Rails.logger.error "Ошибка соединения с базой данных: #{exception.message}"
    render plain: "Ошибка соединения с базой данных. Пожалуйста, попробуйте позже.", status: :service_unavailable
  end
end