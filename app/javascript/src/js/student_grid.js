import React from 'react'

import CollectionGrid from './collection_grid.js'

export default class StudentGrid extends React.Component {
  get columns() {
    return [
      {
        key: 'id',
        name: 'ID',
        width: 35
      },
      {
        key: 'name',
        name: 'Name',
        width: 300
      },
      {
        key: 'completed_lesson_and_part',
        name: 'Completed Lesson and Part',
        width: 300
      },
    ]
  }

  render() {
    return <CollectionGrid title="Students" columns={this.columns}
      collection={this.props.collection} />
  }
}
