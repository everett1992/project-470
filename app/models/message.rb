class Message < ActiveRecord::Base
	scope :newest, order('created_at DESC')

  attr_accessible :body
  belongs_to :dwelling
  belongs_to :user

  validates :user, :presence => true
  validates :dwelling, :presence => true

  validates :body, :presence => true

end
