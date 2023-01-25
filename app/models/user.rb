class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :assets, dependent: :delete_all
  has_many :stocks, through: :assets

  validates :email, :password, :password_confirmation, presence: true

  def name
    email.split('@').first&.capitalize
  end
end
