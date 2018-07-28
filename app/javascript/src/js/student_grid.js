import React from 'react'
import ReactDataGrid from 'react-data-grid'

export class StudentGrid extends React.Component {
  constructor(props, context) {
    super(props, context)

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
    let model = this.props.collection.get(idx + 1)
    return model ? model.attributes : null
  }

  render() {
    return (
      <div>
        <label>Students</label>
        <ReactDataGrid columns={this.columns} rowGetter={this.rowGetter}
          rowsCount={this.props.collection.length} />
      </div>
    )
  }
}
