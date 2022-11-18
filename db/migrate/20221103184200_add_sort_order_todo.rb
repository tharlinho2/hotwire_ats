class AddSortOrderTodo < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :sort_order, :integer
  end
end
