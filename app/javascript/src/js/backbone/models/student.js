const Student = Backbone.Model.extend({
  constructor: function() {
    this.on('change:completed_lesson change:completed_part', () => {
      this.set("completed_lesson_and_part", this.completedLessonAndPart())
    })
    Backbone.Model.apply(this, arguments)
  },

  completedLessonAndPart: function() {
    const lesson = this.get('completed_lesson')
    const part = this.get('completed_part')

    if (!lesson)
      return null

    return `Lesson ${lesson}, part ${part}`
  }
})

export default Student
