class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.invalid?
      render "rooms/show", status: :unprocessable_entity
    end
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if params[:back]
      @room = @reservation.room
      render "rooms/show", status: :unprocessable_entity
    elsif @reservation.save
      redirect_to reservations_path, notice: "予約が確定しました"
    else
      @room = @reservation.room
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params. require(:reservation).permit(:room_id, :checkin_at, :checkout_at, :guest_count)
  end
end
