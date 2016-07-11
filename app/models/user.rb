class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :vehicles
  has_many :service_requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
