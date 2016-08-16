class FileLocation < ApplicationRecord
  #Association
  belongs_to :business_card, primary_key: 'business_card_id', foreign_key: 'business_card_id'
end
