class Token < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  validates :expired_time, presence: true

  has_one :user, primary_key: 'user_id', foreign_key: 'user_id'
end
