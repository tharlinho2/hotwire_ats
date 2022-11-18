class FilesystemItemsController < ApplicationController
  before_action :set_filesystem_item, only: %i[ show edit update destroy ]

  # GET /filesystem_items or /filesystem_items.json
  def index
    @filesystem_items = FilesystemItem.roots
  end

  # GET /filesystem_items/1 or /filesystem_items/1.json
  def show
    html = render_to_string(partial: 'filesystem_items/items', locals: { items: @filesystem_item.descendants })

    render operations: cable_car.inner_html('#items', html: html)
  end

  # GET /filesystem_items/new
  def new
    html = render_to_string(partial: 'form', locals: {filesystem_item: FilesystemItem.new })
    render operations: cable_car
                         .inner_html('#slideover-content', html: html)
                         .text_content('#slideover-header', text: 'Novo File')
  end

  # GET /filesystem_items/1/edit
  def edit
  end

  # POST /filesystem_items or /filesystem_items.json
  def create
    @filesystem_item = FilesystemItem.new(filesystem_item_params)
    if @filesystem_item.save
      html = render_to_string(partial: 'filesystem_items/items', locals: { items: @filesystem_items = FilesystemItem.roots })
      render operations: cable_car
                           .inner_html("#filesystem_items", html: html)
                           .dispatch_event(name: 'submit:success')
    else
      html = render_to_string(partial: 'form', locals: { applicant: @filesystem_item })
      render operations: cable_car.inner_html('#applicant-form', html: html), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /filesystem_items/1 or /filesystem_items/1.json
  def update
    respond_to do |format|
      if @filesystem_item.update(filesystem_item_params)
        format.html { redirect_to filesystem_item_url(@filesystem_item), notice: "Filesystem item was successfully updated." }
        format.json { render :show, status: :ok, location: @filesystem_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @filesystem_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filesystem_items/1 or /filesystem_items/1.json
  def destroy
    @filesystem_item.destroy

    respond_to do |format|
      format.html { redirect_to filesystem_items_url, notice: "Filesystem item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filesystem_item
      @filesystem_item = FilesystemItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filesystem_item_params
      params.require(:filesystem_item).permit(:name, :position, :parent_id)
    end
end
