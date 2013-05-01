class Invite < ActiveRecord::Base
	# Relations
  belongs_to :dwelling

	# Validations
  validates_presence_of :dwelling, :email
  validates_uniqueness_of :email, :scope => :dwelling_id,
    :message => 'An invite has already been seent to this email'

	# Callbacks
  before_create :generate_token

	# Accessible Attributes
  attr_accessible :email, :token, :dwelling_id


	private

	# create a validation token
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
