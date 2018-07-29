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
    return this.props.collection.map(this.linkToStudentReport)
  }

  linkToStudentReport(teacher) {
    const teacherId = teacher.get('id')

    return (
      <Link key={teacherId} to={`/teachers/${teacherId}/student_report`}>
        {teacher.get('name')}
      </Link>
    )
  }
}
