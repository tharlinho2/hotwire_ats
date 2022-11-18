class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :name
      t.integer :sort_order
      t.uuid :parent_id

      t.timestamps
    end
  end
end
