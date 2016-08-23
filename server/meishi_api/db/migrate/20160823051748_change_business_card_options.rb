class ChangeBusinessCardOptions < ActiveRecord::Migration[5.0]
  def change
    change_column_null :business_cards, :name, true
    change_column_null :business_cards, :tel, true
    change_column_null :business_cards, :company_id, true
    change_column_null :business_cards, :department_id, true
  end
end
