class RegisterOfDocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_register_of_document, only: %i[show edit update destroy]

  def index
    @register_of_documents = RegisterOfDocument.all.paginate(page: params[:page], per_page: 7)
  end

  def new
   @register_of_document = RegisterOfDocument.new
  end

  def create
    @register_of_document = RegisterOfDocument.new(register_of_document_params)
    @register_of_document.datascans.attach(params[:datascans])

    if @register_of_document.save!
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    @register_of_document.datascans.attach(params[:datascans])

    if @register_of_document.update(register_of_document_params)
      redirect_to action: "index"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @register_of_document.destroy
      redirect_to action: "index"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def register_of_document_params
    params.require(:register_of_document).permit(:register_of_documents_id, :city, :street, :house_no, datascans: [])
  end

  def find_register_of_document
    @register_of_document = RegisterOfDocument.find(params[:id])
  end
end
