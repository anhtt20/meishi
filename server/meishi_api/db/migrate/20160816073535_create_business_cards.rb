class CreateBusinessCards < ActiveRecord::Migration[5.0]
  def change
    create_table :business_cards, id: false do |t|
      t.column :business_card_id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.string :name, limit: 50, null: false
      t.string :furigana, limit: 50
      t.string :email, limit: 129, null: false
      t.string :tel, limit: 20, null: false
      t.integer :owner_id
      t.datetime :recieve_date

      t.integer :company_id, null: false
      t.integer :department_id, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end

    add_index :business_cards, :business_card_id, :unique => true
  end
end
