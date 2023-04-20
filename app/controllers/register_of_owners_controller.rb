class RegisterOfOwnersController < ApplicationController
  before_action :find_register_of_owner, only: %i[show edit update destroy]

  def index
    if params[:search].present?
      @register_of_owners = RegisterOfOwner.where("street || house_no || ' ' || contractor like ?", "%#{params[:search]}%")
    else
      @register_of_owners = RegisterOfOwner.all
    end
  end

  def new
    @register_of_owner = RegisterOfOwner.new
  end

  def create
    @register_of_owner = RegisterOfOwner.new(register_of_owner_params)
    @register_of_owner.scans.attach(params[:scans])

    if @register_of_owner.save!
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    @register_of_owner.scans.attach(params[:scans])

    if @register_of_owner.update(register_of_owner_params)
      redirect_to action: "index"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    if @register_of_owner.destroy
      redirect_to action: "index"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def register_of_owner_params
    params.require(:register_of_owner).permit(:first_name, :last_name, :middle_name, :personal_account, :city, :street,
                                              :house_no, :apartment_no, :number_owners, :phone, :email, :home_activation_date,
                                              :subscriber_blocking_date, :serial_number, :contractor, :search, scans: [])
  end

  def find_register_of_owner
    @register_of_owner = RegisterOfOwner.find(params[:id])
  end

  def send_fields_access_registrу
    AccessRegistry.new
  end
end
