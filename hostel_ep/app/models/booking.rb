class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :room
  belongs_to :service

  validates :check_in_date, presence: true
  validates :departure_date, presence: true
  validate :check_in_date_must_be_less_than_departure_date

  private

  def check_in_date_must_be_less_than_departure_date
    return if check_in_date.blank? || departure_date.blank?

    if check_in_date >= departure_date
      errors.add(:check_in_date, "должна быть меньше даты выезда")
    end
  end

end