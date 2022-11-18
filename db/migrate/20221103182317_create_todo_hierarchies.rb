class CreateTodoHierarchies < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_hierarchies, id: false do |t|
      t.uuid :ancestor_id, null: false
      t.uuid :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :todo_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "todo_anc_desc_idx"

    add_index :todo_hierarchies, [:descendant_id],
      name: "todo_desc_idx"
  end
end
