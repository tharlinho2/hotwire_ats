class TodoListController < ApplicationController
  before_action :set_todo_list, only: %i[ show edit update destroy move move_item ]

  # GET /lists or /lists.json
  def index
    @todos_list = TodoList.all
  end

  # GET /lists/1 or /lists/1.json
  def show
    html = render_to_string(partial: 'todo_item', locals: { items: @todo_list.todo_filhos })

    render operations: cable_car.inner_html('#todo-items', html: html)
  end

  def move
    @todo_list.insert_at(params[:position].to_i)
  end

  def move_item
    todo_filho = @todo_list.todo_filhos.find(params[:item_id])
    todo_filho.insert_at(params[:position].to_i)
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to list_url(@list), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def list_params
    params.require(:todo_list).permit(:name)
  end
end
