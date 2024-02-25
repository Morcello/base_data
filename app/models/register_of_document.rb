# class RegisterOfDocument < ApplicationRecord
#   has_many_attached :datascans
#
#   validates :city, presence: true, length: { minimum: 3 }
#   validates :street, presence: true, length: { minimum: 3 }
#   validates :house_no, presence: true, length: { minimum: 1 }
# end

class RegisterOfDocument < ApplicationRecord
  has_many_attached :datascans

  validates :city, :street, presence: true, length: { minimum: 3 }
  validates :house_no, presence: true, length: { minimum: 1 }

  # Обеспечить уникальность сочетания city, street, и house_no
  validates :city, uniqueness: { scope: [:street, :house_no], message: "This combination already exists" }

  # Пользовательский метод проверки, гарантирующий, что house_no является положительным целым числом.
  validate :house_no_positive_integer

  private

  def house_no_positive_integer
    if house_no.present? && !house_no.match?(/\A[1-9]\d*\z/)
      errors.add(:house_no, "must be a positive integer")
    end
  end
end
