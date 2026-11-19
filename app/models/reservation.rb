class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :guests, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validate :check_in_cannot_be_in_the_past
  validate :check_out_must_be_after_check_in

  # 宿泊日数の計算
  def stay_days
    return 0 if check_in.blank? || check_out.blank?
    (check_out - check_in).to_i
  end

  # 合計金額の計算（日数 × 人数 × 料金）
  def total_price
    return 0 if stay_days <= 0 || guests.blank?
    stay_days * guests * room.price
  end

  private

  def check_in_cannot_be_in_the_past
    if check_in.present? && check_in < Date.current
      errors.add(:check_in, "は本日以降の日付を選択してください")
    end
  end

  def check_out_must_be_after_check_in
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付を選択してください")
    end
  end
end
