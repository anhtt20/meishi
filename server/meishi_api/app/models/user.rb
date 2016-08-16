class User < ApplicationRecord
  before_save { self.email = email.downcase }

  #validate
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 129 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 60 }

  #association
  has_many :map_roles, primary_key: 'user_id', foreign_key: 'user_id'
  has_many :roles, :through => :map_roles

  has_one :token, primary_key: 'user_id', foreign_key: 'user_id'

  has_secure_password
end
