class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deposits, dependent: :destroy
  has_many :withdrawals, dependent: :destroy

  # Cette fonction garantit que Devise reçoit toujours un vrai string
  def valid_password?(password)
    super(password.to_s)
  end
  
  # Validation du PIN
  validates :pin, presence: true, format: { with: /\A(?!([0-9])\1{3})\d{4}\z/, message: "doit contenir exactement 4 chiffres et ne pas être une répétition (ex: 0000, 1111)" }

  # Role USERS
  enum role: {
    admin: "admin",
    superviseur: "superviseur",
    agent: "agent"
  }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= "agent"
  end
end
