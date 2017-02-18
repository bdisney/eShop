class Contact < ActiveRecord::Base
  validates :email, presence: true
  validates :message, presence: true
  validates :name, presence: true
  validates :subject, presence: true

  validates_length_of :message, :minimum => 3
  validates_length_of :message, :maximum => 140
end
