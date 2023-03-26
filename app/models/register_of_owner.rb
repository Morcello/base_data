class RegisterOfOwner < ApplicationRecord
  #belongs_to :access_registry
  has_many_attached :scans
end
