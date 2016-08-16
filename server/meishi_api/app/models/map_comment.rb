class MapComment < ApplicationRecord
  belongs_to :comment, primary_key: 'comment_id', foreign_key: 'comment_id'
  belongs_to :business_card, primary_key: 'business_card_id', foreign_key: 'business_card_id'
end
