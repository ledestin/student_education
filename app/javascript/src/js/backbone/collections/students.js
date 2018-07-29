import Student from '../models/student.js'

const Students = Backbone.Collection.extend({
  url: function() {
    let url = "/students"
    if (this.teacherId) 
      url += `?teacher_id=${this.teacherId}`

    return url
    
  },

  model: Student
})

export default Students
