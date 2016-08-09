class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
          #:omniauthable
  include DeviseTokenAuth::Concerns::User
  
  has_many :map_roles
  has_many :roles, through: :map_roles
end
