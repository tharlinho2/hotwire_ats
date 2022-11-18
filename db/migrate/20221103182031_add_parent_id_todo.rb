class AddParentIdTodo < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :parent_id, :integer
  end
end
