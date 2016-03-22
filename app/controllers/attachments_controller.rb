class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]
  before_action :check_edit, only: [:edit, :update, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @attachment, notice: 'Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @attachment.update(attachment_params)
      redirect_to @attachment.post, notice: 'Вложение изменено.'
    else
      render :edit
    end
  end

  def destroy
    @attachment.destroy
    redirect_to @attachment.post, notice: 'Вложение удалено.'
  end

  private

  def set_attachment
    @attachment = Attachment.full.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:image, :comment, :position)
  end

  def check_edit
    unless @attachment.edit_by?(@current_user)
      redirect_to root_path, notice: 'Доступ запрещен', status: 403
    end

  end
end
