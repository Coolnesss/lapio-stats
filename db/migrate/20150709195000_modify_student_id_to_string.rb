class ModifyStudentIdToString < ActiveRecord::Migration
  def change
    change_column :submissions, :student_id, :string
  end
end
