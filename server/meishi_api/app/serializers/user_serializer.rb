class UserSerializer < ActiveModel::Serializer
  attributes :user_id, :email
  has_many :roles do 
    User.find(object.user_id).roles.all
  end
  has_one :token do
    Token.find(object.user_id).token
  end
end
