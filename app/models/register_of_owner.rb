class RegisterOfOwner < ApplicationRecord
  #belongs_to :access_registry
  has_many_attached :scans

  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  validates :middle_name, presence: true, length: { minimum: 3 }
  validates :personal_account, presence: true, length: { minimum: 3 }
  validates :city, presence: true, length: { minimum: 3 }
  validates :street, presence: true, length: { minimum: 3 }
  validates :house_no, presence: true, length: { minimum: 1 }
  validates :apartment_no, presence: true, length: { minimum: 1 }
  validates :number_owners, presence: false
  validates :phone, presence: true, length: { minimum: 3 }
  validates :email, presence: true, length: { minimum: 3 }
  validates :home_activation_date, presence: false
  validates :subscriber_blocking_date, presence: false
  validates :serial_number, presence: false
  validates :contractor, presence: false
end
