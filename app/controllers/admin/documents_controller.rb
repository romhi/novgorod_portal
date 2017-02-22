class Admin::DocumentsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  before_action :load_model, only: [:edit, :show, :update, :destroy]

  def index
    @documents = Document.order("title")
  end

  def new
    @document = Document.new
  end

  def show

  end

  def create
    @document = Document.new document_params
    if @document.save
      redirect_to admin_documents_path, notice: "Документ успешно добавлен!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @document.update document_params
      redirect_to admin_documents_path, notice: "Документ успешно обновлен!"
    else
      render :edit
    end
  end

  def destroy
    @document.destroy
    redirect_to admin_documents_path, notice: "Документ успешно удален!"
  end

  def print_document
    @document = Document.find params[:id]
    render layout: false
  end

  private

  def load_model
    @document = Document.find params[:id]
  end

  def document_params
    params.require(:document).permit(:title, :text)
  end

end
