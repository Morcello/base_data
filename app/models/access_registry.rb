class AccessRegistry < ApplicationRecord
  belongs_to :register_of_owner, optional: true

  validates :login, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :password, presence: true, uniqueness: true
end
