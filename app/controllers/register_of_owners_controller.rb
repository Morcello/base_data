class RegisterOfOwnersController < ApplicationController
  before_action :find_register_of_owner, only: %i[show edit update destroy]

  def index
    @register_of_owners = RegisterOfOwner.all
  end

  def new
    @register_of_owner = RegisterOfOwner.new
  end

  def create
    @register_of_owner = RegisterOfOwner.new(register_of_owner_params)
    if @register_of_owner.save!
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @register_of_owner.update(register_of_owner_params)
      redirect_to action: "index"
    else
      render :edit
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
                                              :subscriber_blocking_date, :serial_number, :contractor)
  end

  def find_register_of_owner
    @register_of_owner = RegisterOfOwner.find(params[:id])
  end
end
