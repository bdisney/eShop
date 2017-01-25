class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :second_name, :email, presence: true
  validates_length_of :first_name, :minimum => 3
  validates_length_of :second_name, :minimum => 3

  validates_length_of :password, :minimum => 6
  
end
