# class AccessRegistry < ApplicationRecord
#   belongs_to :register_of_owner, optional: true
#
#   validates :login, presence: true, length: { minimum: 3 }, uniqueness: true
#   validates :password, presence: true, uniqueness: true
# end

class AccessRegistry < ApplicationRecord
  belongs_to :register_of_owner, optional: true

  validates :login, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :password, presence: true

  # Пользовательская проверка для обеспечения уникальности пароля в пределах register_of_owner
  validates :password, uniqueness: { scope: :register_of_owners_id }, if: :register_of_owners_id?

  # Перед проверкой убедитесь, что пароль присутствует.
  before_validation :generate_password, on: :create

  private

  # Сгенерируйте пароль, если он не указан
  def generate_password
    self.password ||= SecureRandom.hex(8) # Generate a random password
  end
end
