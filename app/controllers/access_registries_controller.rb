class AccessRegistriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_access_registry, only: %i[show edit update destroy]

  def index
    @access_registries = AccessRegistry.all
  end

  def new
   @access_registrу = AccessRegistry.new
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
    if @access_registrу.update(access_registry_params)
      redirect_to action: "index"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @access_registrу.destroy
      redirect_to action: "index"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def access_registry_params
    params.require(:access_registry).permit(:register_of_owners_id, :login, :password, :date_application, :date_issue)
  end

  def find_access_registry
    @access_registrу = AccessRegistry.find(params[:id])
  end
end
