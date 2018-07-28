import $ from 'jquery'
import React from 'react'
import ReactDOM from 'react-dom'
import Backbone from 'backbone'

import Students from './backbone/collections/students.js'
import Teachers from './backbone/collections/teachers.js'
import { StudentGrid } from './student_grid.js'
import CollectionGrid from './collection_grid.js'

export class App extends React.Component {
  constructor(props) {
    super(props)

    let students = new Students()
    let teachers = new Teachers()
    this.state = { students, teachers }
  }

  componentDidMount() {
    this.state.students.fetch()
      .then(() => this.setState({}))
      .catch(error => console.log(error))
    this.state.teachers.fetch()
      .then(() => this.setState({}))
      .catch(error => console.log(error))
  }

  render() {
    return (
      <div>
        <CollectionGrid title="Teachers" collection={this.state.teachers} />
        <StudentGrid collection={this.state.students} />
      </div>
    )
  }
}

$(function() {
  ReactDOM.render(<App />, document.getElementById('app'))
})
