class RegisterOfOwnersController < ApplicationController
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
    @register_of_owner = RegisterOfOwner.find(params[:id])
  end

  def update
    @register_of_owner = RegisterOfOwner.find(params[:id])
    # if @register_of_owner.update(register_of_owner_params)
    #   redirect_to action: "index"
    # else
    #   render :new
    # end
  end

  def destroy
    @register_of_owner = RegisterOfOwner.find(params[:id])
    # @register_of_owner.destroy
    # redirect_to register_of_owner_path
  end

  private

  def register_of_owner_params
    params.require(:register_of_owner).permit(:first_name, :last_name, :middle_name, :personal_account,:city, :street,
                                              :house_no, :apartment_no, :number_owners, :phone, :email, :home_activation_date,
                                              :subscriber_blocking_date, :serial_number, :contractor)
  end
end
