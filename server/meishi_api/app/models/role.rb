class Role < ApplicationRecord
  has_many :map_roles
  has_many :users, through: :map_roles
end
