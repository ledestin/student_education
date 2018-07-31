import React from 'react'

const ErrorList = ({ errorMessages }) => {
  return errorMessages.map((errorMessage) => {
    return <p key={errorMessage}
      className="error">{errorMessage}</p>
  })
}

export default ErrorList
