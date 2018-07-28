import React from 'react'
import ReactDataGrid from 'react-data-grid'

export default class CollectionGrid extends React.Component {
  constructor(props) {
    super(props)

    this.columns = [
      {
        key: 'id',
        name: 'ID',
        width: 35
      },
      {
        key: 'name',
        name: 'Name'
      }
    ]
  }

  rowGetter = (idx) => {
    let model = this.props.collection.at(idx)
    return model ? model.attributes : null
  }

  render() {
    return (
      <div>
        <label>{this.props.title}</label>
        <ReactDataGrid columns={this.columns} rowGetter={this.rowGetter}
          rowsCount={this.props.collection.length} />
      </div>
    )
  }
}
