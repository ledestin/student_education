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
    return false unless can_complete_to?(lesson, part)

    self.completed_lesson = lesson
    self.completed_part = part
    true
  end

  private

  def can_complete_to?(lesson, part)
    if no_parts_complete?
      return lesson == 1 && part == 1
    end

    return false if completed_last_lesson?

    if completed_last_part_of_lesson?
      return lesson == completed_lesson + 1 && part == 1
    end

    return part == completed_part + 1
  end

  def no_parts_complete?
    completed_lesson.nil?
  end

  def completed_last_lesson?
    completed_lesson == 100 && completed_part == 3
  end

  def completed_last_part_of_lesson?
    completed_part == 3
  end
end
