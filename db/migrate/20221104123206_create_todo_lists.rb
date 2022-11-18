class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists, id: :uuid do |t|
      t.integer :position
      t.string :name

      t.timestamps
    end
  end
end
