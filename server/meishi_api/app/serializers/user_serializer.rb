class UserSerializer < ActiveModel::Serializer
  attributes :user_id, :email
  # has_many :roles do 
  #   object.roles
  # end
  # has_one :token do
  #   object.token.token
  # end
end
