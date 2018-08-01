class Student < ApplicationRecord
  belongs_to :teacher, required: false

  validates_inclusion_of :completed_lesson, in: 1..100, allow_nil: true
  validates_inclusion_of :completed_part, in: 1..3, allow_nil: true
  validates_each :completed_lesson do |record, attr, value|
    next if record.completed_lesson && record.completed_part
    next if record.completed_lesson.nil? && record.completed_part.nil?

    record.errors.add attr, "and completed_part must be both set or both nil"
  end

  def complete_next_part
    if completed_lesson.nil?
      self.completed_lesson, self.completed_part = 1, 1
      return
    end

    return if completed_lesson == 100 && completed_part == 3

    if completed_part == 3
      self.completed_lesson += 1
      self.completed_part = 1
      return
    end

    self.completed_part += 1
  end
end
