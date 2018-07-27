import $ from 'jquery'
import React from 'react'
import ReactDOM from 'react-dom'
import Backbone from 'backbone'

import Students from './backbone/collections/students.js'

export class App extends React.Component {
  constructor(props) {
    super(props)

    this.students = new Students()
    this.students.fetch().then(() => console.log(this.students.get(1)))
  }

  render() {
    return <div>Hello from App</div>
  }
}

$(function() {
  ReactDOM.render(<App />, document.getElementById('app'))
})
