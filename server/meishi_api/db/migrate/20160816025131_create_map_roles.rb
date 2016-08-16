class CreateMapRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :map_roles, id: false do |t|
      t.integer :role_id, null: false
      t.integer :user_id, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
    add_index :map_roles, [:role_id, :user_id], :unique => true
  end
end
