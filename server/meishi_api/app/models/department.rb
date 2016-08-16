class Department < ApplicationRecord
  #Association
  has_many :business_cards, primary_key: 'deparment_id', foreign_key: 'deparment_id'
end
