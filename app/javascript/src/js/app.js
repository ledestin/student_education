import React from 'react'
import { Route } from 'react-router-dom'
import Backbone from 'backbone'

import Students from './backbone/collections/students.js'
import Teachers from './backbone/collections/teachers.js'
import TeacherList from './teacher_list.js'
import ErrorList from './error_list.js'
import StudentReportPage from './student_report_page.js'

export default class App extends React.Component {
  constructor(props) {
    super(props)

    let students = new Students()
    let teachers = new Teachers()
    this.state = { students, teachers, errors: [] }
  }

  componentDidMount() {
    this.state.students.fetch()
      .then(() => this.setState({}))
      .catch(error => this.addError('Server error'))
    this.state.teachers.fetch()
      .then(() => this.setState({}))
      .catch(error => this.addError('Server error'))
  }

  render() {
    return (
      <div>
        <ErrorList errorMessages={this.state.errors} />
        {this.routes()}
      </div>
    )
  }

  routes() {
    return (
      <div>
        <Route exact path="/" render={(props) => {
          return <TeacherList title="Teachers"
            collection={this.state.teachers} {...props} />
        }} />
        <Route path="/teachers/:teacher_id/student_report"
          render={(props) => {
            return <StudentReportPage
              teachers={this.state.teachers} {...props} />}
          }/>
      </div>
    )
  }

  addError(errorMessage) {
    this.setState((prevState, props) => {
      if (prevState.errors.includes(errorMessage))
        return

      return { errors: [...prevState.errors, errorMessage] }
    })
  }
}
