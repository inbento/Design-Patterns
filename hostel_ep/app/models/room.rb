class Room < ApplicationRecord
  has_many :bookings, dependent: :restrict_with_error
  has_many :clients, through: :bookings
  has_many :services, through: :bookings

  validates :category, presence: true
  validates :capacity, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4, message: "должна быть от 1 до 4" }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "должна быть целым числом" }
                    
  def can_destroy?
    if bookings.empty?
      errors.add(:base, 'Невозможно удалить номер, так как он связан с бронированиями.')
      throw :abort
    end
  end

end