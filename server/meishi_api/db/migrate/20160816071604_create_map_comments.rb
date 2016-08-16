class CreateMapComments < ActiveRecord::Migration[5.0]
  def change
    create_table :map_comments , id: false do |t|
      t.integer :comment_id, null: false
      t.integer :business_card_id, null: false

      t.boolean :deleted, default: false
      t.integer :create_by
      t.integer :update_by
      t.timestamps
    end

    add_index :map_comments, [:comment_id, :business_card_id], :unique => true
  end
end
