import $ from 'jquery'
import React from 'react'
import ReactDOM from 'react-dom'
import Backbone from 'backbone'
import { HashRouter } from 'react-router-dom'

import Students from './backbone/collections/students.js'
import Teachers from './backbone/collections/teachers.js'
import StudentGrid from './student_grid.js'
import CollectionGrid from './collection_grid.js'

export class App extends React.Component {
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
        <CollectionGrid title="Teachers" collection={this.state.teachers} />
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

$(function() {
  ReactDOM.render(
    <HashRouter>
      <App />
    </HashRouter>,
    document.getElementById('app'))
})
