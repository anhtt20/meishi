class FileLocation < ApplicationRecord
  self.primary_keys = :business_card_id, :file_type
  #Association
  belongs_to :business_card, primary_key: 'business_card_id', foreign_key: 'business_card_id'
end
