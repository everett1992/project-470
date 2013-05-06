class Bill < DwellingItem
	# Accessible Attributes
  attr_accessible :amount, :date_due, :name, :owed_to, :status, :dwelling_id

	# Scopes
	scope :upcoming, order(:date_due).where(['date_due >= ?', Date.today])

	# Relations
  has_many :bill_payments
  has_many :users, :through => :dwelling

	# Validations
  validates :amount, :numericality => {:greater_than_or_equal_to => 0}
  validates :date_due, :presence => true
  validates :name, :presence => true
  validates :owed_to, :presence => true

	# filters
  after_initialize :init

  def init
    self.status ||= :unpaid
  end

  def payment_sum
    payment_sum = 0
    self.bill_payments.each do |payment|
      payment_sum += payment.amount
    end
    return payment_sum
  end

  def payment_percentage
    return (self.payment_sum/self.amount)*100.to_int
  end
end
