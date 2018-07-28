import Teacher from '../models/teacher.js'

const Teachers = Backbone.Collection.extend({
  url: "/teachers",
  model: Teacher
})

export default Teachers
