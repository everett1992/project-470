class User < ActiveRecord::Base

	# Accessible Attributes
  attr_accessible :email, :first_name, :cellphone, :last_name, :password, :old_password, :password_confirmation, :dwelling_id

	# Relations
  has_one :owned_dwelling, :class_name => 'Dwelling', :foreign_key => 'owner_id'
  belongs_to :dwelling

  has_many :bill_payments, :foreign_key => 'owner_id'
  has_many :bills, :foreign_key => 'owner_id'
  has_many :events, :foreign_key => 'owner_id'
  has_many :chores, :foreign_key => 'owner_id'
  has_many :shopping_lists, :foreign_key => 'owner_id'
  has_many :comments, :foreign_key => 'owner_id'

	# message has the subtypes post and notification
	# there might be a way to imply those relations, but I don't know how
  has_many :messages, :foreign_key => 'owner_id'
  has_many :posts, :foreign_key => 'owner_id'
  has_many :notifications, :foreign_key => 'owner_id'

	has_many :subscriptions

	# Validations
  validates :email, :presence => true
  validates :email, :uniqueness => true

	# phone numbers can only have numbers and hiphens
	# This is the format amazon SNS wants
	validates :cellphone,
	 	:format => {:with => /^\d-\d{3}-\d{3}-\d{4}$/, :message => 'must match the format X-XXX-XXX-XXXX' },
		:allow_nil => true

	# Users have a password, it is checked for blank?, and confrimation
  has_secure_password

	# Methods

	# return the first and last name, of the email if neither exists
  def name
		if first_name && last_name
			return "#{first_name} #{last_name}"
		else
			return email
		end
  end

	def subscriptions
		subscriptions = {email => nil}
		subscriptions[cellphone] = nil unless cellphone.blank?
		dwelling.topic.subscriptions.each do |subscription|
			subscriptions.each_key do |endpoint|
				# aws strips `-`'s from sms endpoints, check for that
				if subscription.endpoint == (subscription.protocol == :sms ? endpoint.gsub(/-/, '') : endpoint)
					subscriptions[endpoint] = subscription
				end
			end
		end
		return subscriptions
	end

  def avatar_url?
    s3 = AWS::S3.new
    image = s3.buckets[PROFILE_BUCKET].objects[self.avatar_key]
    return image.exists?
  end

  def avatar_url
    s3 = AWS::S3.new
    image = s3.buckets[PROFILE_BUCKET].objects[self.avatar_key]
    if image.exists?
      return image.url_for(:read)
    else
      return nil
    end
  end

  # change this to a hash of the user's email or something
  def avatar_key
    return "#{self.id}_#{self.created_at.to_i}"
  end
end
