class AddPostCodeToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :post_code, :string, null: false, default: '000-0000'
  end
end
