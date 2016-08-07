class User < ActiveRecord::Base
  has_secure_password

  has_many :submissions
  validate :legit_number?, on: :create
  validates :student_id, uniqueness: true
  validates :student_id, presence: true, length: {is: 9}

  def legit_number?
    errors.add(:student_id, "is not valid") unless User.validate_number(self.student_id)
  end

  def self.validate_number(num)
    b = [3, 7, 1, 3, 7, 1, 3, 7]
    return false unless num.length == 9
    a = num.split("").map(&:to_i).take 8
    ans = (10 - (a.zip(b).map{|i,j| i*j }.inject(:+)) % 10) % 10
    return (num[8].to_i == ans)
  end
end
