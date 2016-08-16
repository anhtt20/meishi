class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles, id: false do |t|
      t.column :role_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.string :role_name, limit: 10, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
  end
end
