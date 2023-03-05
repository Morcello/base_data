class ServiceCancellationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_service_cancellation, only: %i[show edit update destroy]

  def index
    @service_cancellations = ServiceCancellation.all
  end

  def new
   @service_cancellation = ServiceCancellation.new
  end

  def create
    @service_cancellation = ServiceCancellation.new(service_cancellation_params)
    if @service_cancellation.save!
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @service_cancellation.update(service_cancellation_params)
      redirect_to action: "index"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @service_cancellation.destroy
      redirect_to action: "index"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def service_cancellation_params
    params.require(:service_cancellation).permit(:register_of_owners_id, :first_name, :last_name, :middle_name, :date_rejection)
  end

  def find_service_cancellation
    @service_cancellation = ServiceCancellation.find(params[:id])
  end
end
