class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :completed_lesson
      t.integer :completed_part

      t.timestamps
    end
  end
end
