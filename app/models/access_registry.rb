class AccessRegistry < ApplicationRecord
  belongs_to :register_of_owner, optional: true

  validates :login, presence: true, absence: true, length: { minimum: 3 }
  validates :password, presence: true, absence: true, uniqueness: true
end
