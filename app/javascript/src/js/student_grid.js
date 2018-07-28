import React from 'react'

import CollectionGrid from './collection_grid.js'

export default class StudentGrid extends React.Component {
  render() {
    return <CollectionGrid title="Students"
      collection={this.props.collection} />
  }
}
