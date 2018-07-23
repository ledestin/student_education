class MakeStudentBelongToTeacher < ActiveRecord::Migration[5.2]
  def change
    change_table(:students) do |t|
      t.references :teacher
    end

    add_foreign_key(:students, :teachers, on_delete: :nullify)
  end
end
