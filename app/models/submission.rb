class Submission < ActiveRecord::Base
  belongs_to :week

  validates :student_id, presence: true, length: {is: 9}

  def self.search(search)
    where("student_id LIKE ?", "%#{search}%")
  end

  def percentage
    ((self.points.to_f / self.week.max_points) * 100).round(2)
  end
end
