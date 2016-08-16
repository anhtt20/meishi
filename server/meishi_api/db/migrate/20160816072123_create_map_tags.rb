class CreateMapTags < ActiveRecord::Migration[5.0]
  def change
    create_table :map_tags, id: false do |t|
      t.integer :tag_id, null: false
      t.integer :business_card_id, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end

    add_index :map_tags, [:tag_id, :business_card_id], :unique => true
  end
end
