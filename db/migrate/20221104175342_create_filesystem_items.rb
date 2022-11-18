class CreateFilesystemItems < ActiveRecord::Migration[7.0]
  def change
    create_table :filesystem_items, id: :uuid do |t|
      t.string :name
      t.integer :position
      t.uuid :parent_id

      t.timestamps
    end
  end
end
