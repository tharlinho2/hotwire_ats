class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items, id: :uuid do |t|
      t.string :description
      t.integer :position
      t.references :todo, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
