class CreateTodoFilhos < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_filhos, id: :uuid do |t|
      t.string :name
      t.integer :position
      t.references :todo_list, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
