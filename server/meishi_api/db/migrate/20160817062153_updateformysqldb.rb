class Updateformysqldb < ActiveRecord::Migration[5.0]
  def change
    #post code
    change_column :companies, :post_code, :string, limit: 8
  end
end
