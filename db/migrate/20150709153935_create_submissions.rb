class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :week_id
      t.integer :student_id
      t.integer :points

      t.timestamps null: false
    end
  end
end
