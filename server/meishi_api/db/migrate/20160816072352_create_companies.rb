class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies, id: false do |t|
      t.column :company_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.string :name, limit: 150, null: false
      t.text :address, limit: 1000, null: false
      t.string :email, limit: 129
      t.string :tel, limit: 20
      t.string :fax, limit: 20
      t.string :url, limit: 150

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end
  end
end
