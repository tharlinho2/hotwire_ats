class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos, id: :uuid do |t|
      t.string :description
      t.integer :position

      t.timestamps
    end
  end
end
