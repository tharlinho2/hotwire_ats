class ListItemsController < ApplicationController
  before_action :set_todo_item, only: %i[ show edit update destroy move ]

  # GET /todos or /todos.json
  def index
    @todos = TodoItem.all
  end

  # GET /todos/1 or /todos/1.json
  def show
    html = render_to_string(partial: 'todo_item', locals: { items: @todo_list.todo_items })

    render operations: cable_car
                         .inner_html('#todo-items', html: html)
  end

  # GET /todos/new
  def new
    @todo = TodoItem.new
  end

  # GET /todos/1/edit
  def edit
  end

  def move
    @todo.insert_at(params[:position].to_i)
  end

  # POST /todos or /todos.json
  def create
    @todo = TodoItem.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_todo_item
    @todo = TodoItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_item_params
    params.require(:todo).permit(:description, :position)
  end
end
