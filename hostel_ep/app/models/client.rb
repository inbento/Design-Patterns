class Client < ApplicationRecord
  before_validation :normalize_phone_number
  has_many :bookings, dependent: :restrict_with_error
  has_many :rooms, through: :bookings
  has_many :services, through: :bookings

    # Валидация ФИО: формат "Абоба.А.А" и длина до 15 символов
  validates :last_name_and_initials, presence: true,
                                     format: { with: /\A[А-Яа-я]+\.([А-Яа-я]\.){2}\z/, message: "должно быть в формате: Абоба.А.А" },
                                     length: { maximum: 15 }

  # Валидация паспорта: формат "xx xx xxxxxx" (только цифры)
  validates :passport, presence: true,
                       format: { with: /\A\s*\d{2}\s+\d{2}\s+\d{6}\s*\z/, message: "должен быть в формате: xx xx xxxxxx" },
                       uniqueness: true

  # Валидация телефона: формат "8хххххххххх" или "+7хххххххххх"
  validates :telephone, presence: true,
                        format: { with: /\A(\+7|8)\d{10}\z/, message: "должен быть в формате: 8хххххххххх или +7хххххххххх" },
                        uniqueness: true

  def can_destroy?
    if bookings.empty?
      errors.add(:base, 'Невозможно удалить клиента, так как он связан с бронированиями.')
      throw :abort
    end
  end

  private

  def normalize_phone_number
    return if telephone.blank?
    self.telephone = telephone.gsub(/\D/, '')
    if telephone.start_with?('8') && telephone.length == 11
      self.telephone = '+7' + telephone[1..-1]
    elsif telephone.start_with?('7') && telephone.length == 11
      self.telephone = '+' + telephone
    end
  end

end