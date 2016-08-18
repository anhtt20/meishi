class Company < ApplicationRecord
  #Association
  has_many :business_cards, primary_key: 'company_id', foreign_key: 'company_id'


end
