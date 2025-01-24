class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.can_destroy?
      @room.destroy
      redirect_to rooms_url, notice: 'Номер успешно удалён.'
    else
      redirect_to rooms_url, alert: 'Невозможно удалить номер, так как он связан с бронированиями.'
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:category, :capacity, :price)
  end
end