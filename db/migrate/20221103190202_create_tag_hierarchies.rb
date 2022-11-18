class CreateTagHierarchies < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_hierarchies, id: false do |t|
      t.uuid :ancestor_id, null: false
      t.uuid :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :tag_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "tag_anc_desc_idx"

    add_index :tag_hierarchies, [:descendant_id],
      name: "tag_desc_idx"
  end
end
