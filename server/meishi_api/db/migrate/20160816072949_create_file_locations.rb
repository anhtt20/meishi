class CreateFileLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :file_locations, id: false do |t|
      t.string :type, limit: 3, null: false, default: 'OMT'
      t.integer :business_card_id, null: false
      t.string :path, limit: 500, null: false
      t.string :domain, limit: 500, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end

    add_index :file_locations, [:type, :business_card_id], :unique => true
  end
end
