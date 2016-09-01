class Week < ActiveRecord::Base
  has_many :submissions

  validates :name, presence: true
  validates :max_points, presence: true

  def to_s
    name
  end
end
