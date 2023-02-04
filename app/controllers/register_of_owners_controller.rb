class RegisterOfOwnersController < ApplicationController
  def index
  end

  def new
    @register_of_owner = RegisterOfOwner.new
  end

  def create

  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def register_of_owner_params
    params.require(:register_of_owner).permit(:first_name, :last_name)

  end
end
