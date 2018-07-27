import Backbone from 'backbone'
import Students from './backbone/collections/students.js'

export class App {
  constructor() {
    this.students = new Students()
    this.students.fetch().then(() => console.log(this.students.get(1)))
  }

  hello = () => {
    console.log("Hello from App")
  }
}

new App().hello()
