class Dwelling < ActiveRecord::Base
	# Accessible Attributes
	attr_accessor :topic # dwellings sns topic
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
  before_save :ensure_owner_has_this_dwelling

	before_create :create_sns_topic, :if => :valid?
	after_destroy :delete_sns_topic

	# Amazon SNS topic for this dwelling
	def topic
		return @topic ||= get_topic
	end

	private

	def get_topic
		if !topic_arn
			@topic = nil
		elsif AWS.config.stub_requests
			# Fake it
			@topic = AWS::SNS::Topic.new(topic_arn)
		else
			begin 
				sns = AWS::SNS.new
				@topic = sns.topics[topic_arn]
			rescue
				# Something Broke
				@topic = nil
			end
		end
	end

	# Create an sns topic with the dwellings name as it's name
	# and display name
	def create_sns_topic
		if AWS.config.stub_requests
			# faking aws requests, fake topics
			self.topic_arn = 'arn'
		else
			sns = AWS::SNS.new
			@topic = sns.topics.create(name.gsub(/ /, '_'))
			@topic.display_name = name
			self.topic_arn = topic.arn
		end
	end

	def delete_sns_topic
		unless AWS.config.stub_requests
			topic.delete if topic
		end
	end

  def ensure_owner_has_this_dwelling
    self.owner.dwelling = self
  end
end
