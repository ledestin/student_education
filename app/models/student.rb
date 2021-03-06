class Student < ApplicationRecord
  belongs_to :teacher, required: false

  LESSON_RANGE = LessonProgress::FIRST_LESSON..LessonProgress::LAST_LESSON
  PART_RANGE = LessonProgress::FIRST_PART..LessonProgress::LAST_PART

  validates_uniqueness_of :name
  validates_inclusion_of :completed_lesson,
    in: LESSON_RANGE, allow_nil: true,
    message: "must be in #{LESSON_RANGE} range"
  validates_inclusion_of :completed_part,
    in: PART_RANGE, allow_nil: true, message: "must be in #{PART_RANGE} range"
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
