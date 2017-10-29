class PinsController < ApplicationController
  before_action :find_pin, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @pins = Pin.all.order('created_at DESC')
  end

  def new
    @pin = current_user.pins.new
  end

  def show

  end

  def create
    @pin = current_user.pins.new(pin_params)
    if @pin.save
      redirect_to @pin, notice: t('pin.created.success')
    else
      render :new, danger: t('pin.created.failed')
    end
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: t('pin.updated.success')
    else
      render :edit, danger: t('pin.updated.failed')
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path, notice: t('pin.deleted')
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to @pin
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
