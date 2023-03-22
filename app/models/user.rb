class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tradings, dependent: :delete_all
  has_many :assets, dependent: :delete_all
  has_many :stocks, through: :assets
  has_many :proceeds, dependent: :delete_all

  validates :email, :password, :password_confirmation, presence: true

  def name
    email.split('@').first&.capitalize
  end
end
