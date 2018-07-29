import React from 'react'

import Students from './backbone/collections/students.js'
import StudentGrid from './student_grid.js'

export default class StudentReportPage extends React.Component {
  constructor(props) {
    super(props)

    const students = new Students()
    students.teacherId = this.teacherId()
    this.state = { students }
  }

  componentDidMount() {
    this.state.students.fetch()
      .then(() => this.setState({}))
      .catch((error) => console.log(error))
  }

  render() {
    return (
      <div>
        <h1>{this.header()}</h1>
        <StudentGrid collection={this.state.students} />
      </div>
    )
  }

  header() {
    const teacher = this.teacher()
    if (!teacher)
      return 'Loading...'

    return `Teacher ${teacher.get('name')}`
  }

  teacherId() {
    return this.props.match.params["teacher_id"]
  }

  teacher() {
    return this.props.teachers.get(this.teacherId())
  }
}
