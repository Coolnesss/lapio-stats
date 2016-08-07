class Submission < ActiveRecord::Base

  belongs_to :week
  belongs_to :user

  #validates :student_id, presence: true, length: {is: 9},
  #  uniqueness: {
  #    scope: :week_id, message: "ID already has a submission for this week."
  #  }
  validate :points_is_less_or_equal_then_max
  validates_numericality_of :points, greater_than: 0

  def duplicate
    Submission.find_by(user: self.user, week: week)
  end

  def self.search(search)
    Submission.joins(:user).where("users.student_id LIKE ?", "%#{search}%")
  end

  def percentage
    ((self.points.to_f / self.week.max_points) * 100).round(2)
  end

  private
    def points_is_less_or_equal_then_max
      errors.add(:points, "should be less than #{self.week.max_points}, which is the maximum amount for the week.") if points > self.week.max_points
    end
end
