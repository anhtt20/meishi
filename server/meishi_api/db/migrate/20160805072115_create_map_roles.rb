class CreateMapRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :map_roles do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end
end
