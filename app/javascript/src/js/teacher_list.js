import React from 'react'
import { Link } from 'react-router-dom'

export default class TeacherList extends React.Component {
  render() {
    return (
      <div>
        <label>{this.props.title}</label>
        {this.teachers()}
      </div>
    )
  }

  teachers() {
    return this.props.collection.map(this.linkToStudentList)
  }

  linkToStudentList(teacher) {
    const teacherId = teacher.get('id')

    return (
      <Link key={teacherId} to={`/student_list/${teacherId}`}>
        {teacher.get('name')}
      </Link>
    )
  }
}
