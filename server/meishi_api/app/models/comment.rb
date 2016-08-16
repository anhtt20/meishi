class Comment < ApplicationRecord
  has_many :map_comments, primary_key: 'comment_id', foreign_key: 'comment_id'
  has_many :business_cards, :through => :map_comments
end
