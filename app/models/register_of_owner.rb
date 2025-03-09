class RegisterOfOwner < ApplicationRecord
  #belongs_to :access_registry
  has_many_attached :scans

  validates :first_name, :last_name, presence: true, length: { minimum: 3 }
  validates :middle_name, length: { maximum: 255 }, allow_nil: true
  validates :scans, presence: false
  validates :personal_account, uniqueness: true, presence: true, length: { minimum: 3 }
  validates :city, presence: true, length: { minimum: 3 }
  validates :street, presence: true, length: { minimum: 3 }
  validates :house_no, presence: true, length: { minimum: 1 }
  validates :apartment_no, presence: true, length: { minimum: 1 }
  validates :number_owners, presence: false
  validates :phone, presence: true, format: { with: /\A\+7\d{10}\z/, message: "Номер телефона должен быть в формате +7 (XXX) XXX-XX-XX" }
  validates :email, presence: true, length: { minimum: 3 }
  validates :home_activation_date, presence: false
  validates :subscriber_blocking_date, presence: false
  validates :serial_number, presence: false
  validates :contractor, presence: false

  attr_accessor :subscriber_blocking_date_enabled  # Добавляем виртуальное поле
end
