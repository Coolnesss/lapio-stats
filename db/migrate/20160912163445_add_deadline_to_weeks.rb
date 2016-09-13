class AddDeadlineToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :deadline, :timestamps
  end
end
