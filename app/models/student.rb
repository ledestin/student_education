class Student < ApplicationRecord
  belongs_to :teacher, required: false

  validates_inclusion_of :completed_lesson, in: 1..100, allow_nil: true
  validates_inclusion_of :completed_part, in: 1..3, allow_nil: true
  validates_each :completed_lesson do |record, attr, value|
    next if record.completed_lesson && record.completed_part
    next if record.completed_lesson.nil? && record.completed_part.nil?

    record.errors.add attr, "and completed_part must be both set or both nil"
  end

  def complete(lesson, part)
    return false unless can_complete?(lesson, part)

    self.completed_lesson = lesson
    self.completed_part = part
    true
  end

  private

  def can_complete?(lesson, part)
    if completed_lesson.nil?
      return lesson == 1 && part == 1
    end

    return false if completed_lesson == 100 && completed_part == 3

    if completed_part == 3
      return lesson == completed_lesson + 1 && part == 1
    end

    return part == completed_part + 1
  end
end
