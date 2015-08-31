class Submission < ActiveRecord::Base

  belongs_to :week
  belongs_to :user

  validate :legit_number?, on: :create

  validates :student_id, presence: true, length: {is: 9},
    uniqueness: {
      scope: :week_id, message: "ID already has a submission for this week."
    }
  validate :points_is_less_or_equal_then_max

  def duplicate
    Submission.where(student_id: student_id, week: week).first
  end

  def self.search(search)
    where("student_id LIKE ?", "%#{search}%")
  end

  def percentage
    ((self.points.to_f / self.week.max_points) * 100).round(2)
  end

  def legit_number?
    errors.add(:student_id, "ID is not valid") unless Submission.validate_number(self.student_id)
  end

  def self.validate_number(num)
    b = [3, 7, 1, 3, 7, 1, 3, 7]
    return false unless num.length == 9
    a = num.split("").map{|p| p.to_i}.take(8)
    ans = (10 - (a.zip(b).map{|i,j| i*j }.inject(:+)) % 10) % 10
    return (num[8].to_i == ans)
  end

  private
    def points_is_less_or_equal_then_max
      errors.add(:points, "should be less than #{self.week.max_points}, which is the maximum amount for the week.") if points > self.week.max_points
    end
end
