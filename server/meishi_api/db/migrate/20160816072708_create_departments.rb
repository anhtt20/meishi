class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments, id: false do |t|
      t.column :department_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.string :name, limit: 50, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
  end
end
