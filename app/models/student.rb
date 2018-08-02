class Student < ApplicationRecord
  belongs_to :teacher, required: false

  validates_inclusion_of :completed_lesson,
    in: LessonProgress::FIRST_LESSON..LessonProgress::LAST_LESSON,
    allow_nil: true
  validates_inclusion_of :completed_part,
    in: LessonProgress::FIRST_PART..LessonProgress::LAST_PART, allow_nil: true
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
    current_progress = LessonProgress.new(completed_lesson, completed_part)
    new_progress = LessonProgress.new(lesson, part)

    new_progress == current_progress.next
  end
end
