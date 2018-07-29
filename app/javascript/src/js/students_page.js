import React from 'react'

import Students from './backbone/collections/students.js'
import StudentGrid from './student_grid.js'

export default class StudentsPage extends React.Component {
  constructor(props) {
    super(props)

    const students = new Students()
    students.teacherId = props.match.params["teacher_id"]
    this.state = { students }
  }

  componentDidMount() {
    this.state.students.fetch()
      .then(() => this.setState({}))
      .catch((error) => console.log(error))
  }

  render() {
    return <StudentGrid collection={this.state.students} />
  }
}