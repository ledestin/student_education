class LessonProgress
  FIRST_LESSON = 1
  LAST_LESSON = 100
  FIRST_PART = 1
  LAST_PART = 3

  attr_reader :lesson, :part

  def initialize(lesson, part)
    @lesson, @part = lesson, part
  end

  def ==(other)
    @lesson == other.lesson && @part == other.part
  end

  def next
    return self.class.new(FIRST_LESSON, FIRST_PART) if no_parts_complete?
    return self if last_lesson_and_part?

    if last_part_of_lesson?
      self.class.new(@lesson.next, FIRST_PART)
    else
      self.class.new(@lesson, @part.next)
    end
  end

  private

  def no_parts_complete?
    @lesson.nil?
  end

  def first_part_ever_complete?
    @lesson == FIRST_LESSON && @part == FIRST_PART
  end

  def last_part_of_lesson?
    @part == LAST_PART
  end

  def last_lesson_and_part?
    @lesson == LAST_LESSON and @part == LAST_PART
  end

end
