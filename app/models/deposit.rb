class Deposit < ApplicationRecord
  belongs_to :user
  has_many :deposits

  validates :client_phone, presence: true
  validates :amount, numericality: { greater_than: 0 }

  before_create :generate_reference
  after_initialize :set_default_status, if: :new_record?

  private

  def generate_reference
    self.reference = "DEP#{Time.now.strftime('%Y%m%d%H%M%S')}#{rand(100..999)}"
  end

  def set_default_status
    self.status ||= "pending"
  end
end