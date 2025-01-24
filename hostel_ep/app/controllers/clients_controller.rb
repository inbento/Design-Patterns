class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    if @client.can_destroy?
      @client.destroy
      redirect_to clients_url, notice: 'Клиент успешно удалён.'
    else
      redirect_to clients_url, alert: 'Невозможно удалить клиента, так как он связан с бронированиями.'
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:last_name_and_initials, :passport, :telephone)
  end
end