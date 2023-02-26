class AccessRegistriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_access_registry, only: %i[show edit update destroy]

  def index
    @access_registries = AccessRegistry.all
  end

  def new
   @access_registrу = AccessRegistry.all
  end

  def create
    @access_registrу = AccessRegistry.new(access_registry_params)
    if @access_registrу.save!
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

  def access_registry_params
    params.require(:access_registrу).permit(:register_of_owner_id, :login, :password, :date_application, :date_issue)
  end

  def find_register_of_owner
    @access_registries = AccessRegistry.find(params[:id])
  end
end
