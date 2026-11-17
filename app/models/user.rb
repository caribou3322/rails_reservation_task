class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rooms, dependent: :destoroy
  has_many :reservations, dependent: :destoroy
  has_one_attached :avatar

  validates :name, presence: true
end
