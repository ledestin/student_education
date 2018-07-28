import React from 'react'
import { Link } from 'react-router-dom'

export default class TeacherList extends React.Component {
  render() {
    const teachers = this.props.collection.map((teacher) => {
      const teacher_id = teacher.get('id')

      return (
        <Link key={teacher_id} to={`/student_list?teacher_id=${teacher_id}`}>
          {teacher.get('name')}
        </Link>
      )
    })

    return (
      <div>
        <label>{this.props.title}</label>
        {teachers}
      </div>
    )
  }
}
