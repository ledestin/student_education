import React from 'react'
import Backbone from 'backbone'

import Students from './backbone/collections/students.js'
import Teachers from './backbone/collections/teachers.js'
import StudentGrid from './student_grid.js'
import TeacherList from './teacher_list.js'

export default class App extends React.Component {
  constructor(props) {
    super(props)

    let students = new Students()
    let teachers = new Teachers()
    this.state = { students, teachers, errors: {} }
  }

  componentDidMount() {
    this.state.students.fetch()
      .then(() => this.clearError('students'))
      .catch(error => this.setError('students', error.statusText))
    this.state.teachers.fetch()
      .then(() => this.clearError('teachers'))
      .catch(error => this.setError('teachers', error.statusText))
  }

  render() {
    return (
      <div>
        {this.errors()}
        <TeacherList title="Teachers" collection={this.state.teachers} />
        <StudentGrid collection={this.state.students} />
      </div>
    )
  }

  errors() {
    const errorEntries = Object.entries(this.state.errors)
    const result = errorEntries.map(([key, errorMessage]) => {
      if (!errorMessage)
        return

      return <p key={key}
        className="error">Error loading {key}: {errorMessage}</p>
    })

    return result
  }

  setError(key, errorMessage) {
    this.setState((prevState, props) => {
      return { errors: {...prevState.errors, [key]: errorMessage} }
    })
  }

  clearError(key) {
    this.setError(key, null)
  }
}
