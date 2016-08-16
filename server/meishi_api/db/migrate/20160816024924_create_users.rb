class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users , id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.string :email, limit: 129, null: false
      t.string :password_digest, limit: 60, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
  end
end
