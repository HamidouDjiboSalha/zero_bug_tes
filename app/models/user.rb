class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Cette fonction garantit que Devise reçoit toujours un vrai string
  def valid_password?(password)
    super(password.to_s)
  end
  
  validates :pin, presence: true, format: { with: /\A\d{4}\z/, message: "doit contenir exactement 4 chiffres" }
end
