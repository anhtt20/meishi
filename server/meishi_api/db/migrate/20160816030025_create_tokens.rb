class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens , id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.string :token, limit: 60, null: false
      t.string :exprired_time, limit: 10, null: false

      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
  end
end
