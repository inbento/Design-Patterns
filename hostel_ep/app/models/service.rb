class Service < ApplicationRecord
  has_many :bookings, dependent: :restrict_with_error
  has_many :clients, through: :bookings
  has_many :rooms, through: :bookings

  validates :title, presence: true,
                    length: { maximum: 30, message: "не может превышать 30 символов" },
                    uniqueness: { message: "услуга с таким названием уже существует" }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "должна быть целым числом" }

  def can_destroy?
    if bookings.empty?
      errors.add(:base, 'Невозможно удалить услугу, так как она связана с бронированиями.')
      throw :abort
    end
  end

end