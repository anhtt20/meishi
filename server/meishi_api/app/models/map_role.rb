class MapRole < ApplicationRecord
  belongs_to :user,inverse_of: :map_roles
  belongs_to :role,inverse_of: :map_roles
end
