class Tag < ApplicationRecord
  has_many :map_tags, primary_key: 'tag_id', foreign_key: 'tag_id'
  has_many :business_cards, :through => :map_tags
end
