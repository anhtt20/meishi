class BusinessCard < ApplicationRecord

  #Association
  #With Tag
  has_many :map_tags, primary_key: 'business_card_id', foreign_key: 'business_card_id'
  has_many :tags, :through => :map_tags
  #with Comment
  has_many :map_comments, primary_key: 'business_card_id', foreign_key: 'business_card_id'
  has_many :comments, :through => :map_comments
  #with Company
  belongs_to :company, primary_key: 'company_id', foreign_key: 'company_id'
  #with department
  has_one :department, primary_key: 'department_id', foreign_key: 'department_id'
  #with file_locations
  has_many :file_locations, primary_key: 'business_card_id', foreign_key: 'business_card_id'

end
