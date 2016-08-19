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
  has_many :comments, if: -> { scope[:action] != 'fetch' }
  has_one :mine do
    object.owner_id and object.owner_id == scope[:user_id]
  end
  has_one :my_card do 
    object.create_by and object.create_by == scope[:user_id]
  end
end
