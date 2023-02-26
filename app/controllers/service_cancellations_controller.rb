class ServiceCancellationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_service_cancellation, only: %i[show edit update destroy]

  def index
    @service_cancellations = ServiceCancellation.all
  end

  def new
   @service_cancellation = ServiceCancellation.all
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
  end

  private

  def service_cancellation_params
    params.require(:service_cancellation).permit(:service_cancellation_id, :first_name, :last_name, :middle_name, :date_rejection)
  end

  def find_service_cancellation
    @service_cancellations = ServiceCancellation.find(params[:id])
  end
end
