class Submission < ActiveRecord::Base
  belongs_to :week

  validates :student_id,
    :format => { :with => /\A0\d{8}\z/, :message => "Not a valid student number" }
end
