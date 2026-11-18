class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :checkin_at, presence: true
  validates :checkout_at, presence: true
  validates :guest_count, presence: true, numericality: { greater_than_or_equal_to: 1 }

  validate :checkin_at_cannot_be_in_the_past
  validate :checkout_at_must_be_after_checkin_at

  # 宿泊日数の計算
  def stay_days
    return 0 if checkin_at.blank? || checkout_at.blank?
    (checkout_at - checkin_at).to_i
  end

  # 合計金額の計算(日数×料金×人数)
  def total_price
    stay_days * room.price * guest_count.to_i
  end

  private

  def checkin_at_cannot_be_in_the_past
    if checkin_at.present? && checkin_at < Date.current_password
      errors.add(:checkin_at, "は本日以降の日付を選択してください")
    end
  end

  def checkout_at_must_be_after_checkin_at
    if checkin_at.present? && checkout_at.present? && checkout_at <= checkin_at
      errors.add(:checkout_at, "はチェックイン以降の日付を選択してください")
    end
  end
end
