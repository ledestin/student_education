import $ from 'jquery'
import React from 'react'
import ReactDOM from 'react-dom'
import Backbone from 'backbone'

import Students from './backbone/collections/students.js'
import { StudentGrid } from './student_grid.js'

export class App extends React.Component {
  constructor(props) {
    super(props)

    let students = new Students()
    this.state = { students }
  }

  componentDidMount() {
    this.state.students.fetch()
      .then(() => this.setState({}))
      .catch(error => console.log(error))
  }

  render() {
    return <StudentGrid collection={this.state.students} />
  }
}

$(function() {
  ReactDOM.render(<App />, document.getElementById('app'))
})
