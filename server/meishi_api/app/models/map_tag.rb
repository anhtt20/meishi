class MapTag < ApplicationRecord
  belongs_to :tag, primary_key: 'tag_id', foreign_key: 'tag_id'
  belongs_to :business_card, primary_key: 'business_card_id', foreign_key: 'business_card_id'
end
