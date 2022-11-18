class CreateFilesystemItemHierarchies < ActiveRecord::Migration[7.0]
  def change
    create_table :filesystem_item_hierarchies, id: false do |t|
      t.uuid :ancestor_id, null: false
      t.uuid :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :filesystem_item_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "filesystem_item_anc_desc_idx"

    add_index :filesystem_item_hierarchies, [:descendant_id],
      name: "filesystem_item_desc_idx"
  end
end
