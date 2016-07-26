class User < ActiveRecord::Base
  has_secure_password

  has_many :submissions

  validates :name, uniqueness: true
end
