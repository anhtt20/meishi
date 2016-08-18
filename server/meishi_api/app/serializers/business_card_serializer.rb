class BusinessCardSerializer < ActiveModel::Serializer
  attributes  :business_card_id,
              :name,
              :furigana,
              :email,
              :tel,
              :recieve_date
  belongs_to :company
  belongs_to :department
  has_many :file_locations
  has_many :comments
end
