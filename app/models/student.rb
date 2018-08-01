class Student < ApplicationRecord
  belongs_to :teacher, required: false

  validates_inclusion_of :completed_lesson, in: 1..100, allow_nil: true
  validates_inclusion_of :completed_part, in: 1..3, allow_nil: true
  validates_each :completed_lesson do |record, attr, value|
    next if record.completed_lesson && record.completed_part
    next if record.completed_lesson.nil? && record.completed_part.nil?

    record.errors.add attr, "and completed_part must be both set or both nil"
  end
end
