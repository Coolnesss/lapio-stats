class Week < ActiveRecord::Base
  has_many :submissions

  validates :name, presence: true
  validates :max_points, presence: true

  def to_s
    name
  end

  def self.deadlines
    "[" + Week.all.pluck(:deadline).map(&:to_f).map{|x| x*1000}.join(",") + "]"
  end
end
