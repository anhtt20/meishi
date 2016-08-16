class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments, id: false do |t|
      t.column :comment_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.text :content, limit: 500

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
  end
end
