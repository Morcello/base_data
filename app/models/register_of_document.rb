class RegisterOfDocument < ApplicationRecord
  has_many_attached :datascans

  validates :city, presence: true, length: { minimum: 3 }
  validates :street, presence: true, length: { minimum: 3 }
  validates :house_no, presence: true, length: { minimum: 3 }
end
