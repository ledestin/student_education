class MakeStudentNameNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :students, :name, :string, null: false
  end
end
