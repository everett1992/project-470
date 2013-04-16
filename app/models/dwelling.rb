class Dwelling < ActiveRecord::Base
	# Accessible Attributes
  attr_accessible :name, :owner, :time_zone

	# Relations
  belongs_to :owner, :class_name => 'User'
  has_many :users
  has_many :invites
  has_many :bills
  has_many :events
  has_many :chores
  has_many :shopping_lists
  has_many :comments
	
	# message has the subtype post and notification
	# there might be a way to simplify these lines
  has_many :messages
  has_many :posts
  has_many :notifications

	# Validations
  validates_presence_of :name, :owner

	# Callbacks
  after_save :ensure_owner_has_this_dwelling

  def ensure_owner_has_this_dwelling
    self.owner.dwelling = self
    self.owner.save
  end
end
