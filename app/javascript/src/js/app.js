import $ from 'jquery'
import React from 'react'
import { withRouter } from 'react-router'
import { Route } from 'react-router-dom'
import Backbone from 'backbone'

import Students from './backbone/collections/students.js'
import Teachers from './backbone/collections/teachers.js'
import TeacherList from './teacher_list.js'
import ErrorList from './error_list.js'
import StudentReportPage from './student_report_page.js'

class App extends React.Component {
  constructor(props) {
    super(props)

    const teachers = new Teachers()
    this.state = { teachers, errors: [] }
  }

  componentDidMount() {
    this.setupAjaxSuccessesToUpdateState()
    this.setupAjaxFailuresToUpdateErrors()

    this.state.teachers.fetch()
  }

  componentWillUnmount() {
    this.unbindAjaxCallbacks()
  }

  componentWillReceiveProps(nextProps) {
    if (this.isLocationChanged(nextProps)) {
      this.clearErrors()
    }
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

  isLocationChanged(nextProps) {
    return nextProps.location !== this.props.location
  }

  setupAjaxSuccessesToUpdateState() {
    $(document).ajaxSuccess(() => this.setState({}))
  }

  setupAjaxFailuresToUpdateErrors() {
    $(document).ajaxError(() => this.addError('Server error'))
  }

  unbindAjaxCallbacks() {
    $(document).unbind('ajaxSuccess')
    $(document).unbind('ajaxError')
  }

  addError(errorMessage) {
    this.setState((prevState, props) => {
      if (prevState.errors.includes(errorMessage))
        return

      return { errors: [...prevState.errors, errorMessage] }
    })
  }

  clearErrors() {
    this.setState({ errors: [] })
  }
}

export default withRouter(App)
