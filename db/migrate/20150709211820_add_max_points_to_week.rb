class AddMaxPointsToWeek < ActiveRecord::Migration
  def change
    add_column :weeks, :max_points, :integer
  end
end
