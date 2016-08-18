class AddCommentIdToMeishi < ActiveRecord::Migration[5.0]
  def change
    add_column :business_cards, :comment_id, :integer
  end
end
