class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags , id: false do |t|
      t.column :tag_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.string :name, limit: 30, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
  end
end
