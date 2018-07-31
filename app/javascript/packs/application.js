/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'babel-polyfill'
import $ from 'jquery'
import React from 'react'
import ReactDOM from 'react-dom'
import { HashRouter } from 'react-router-dom'
import { AppContainer } from 'react-hot-loader'

import App from '../src/js/app.js'
import initCapybaraSupport from '../src/js/capybara.js'

console.log('Hello World from Webpacker')

const render = Component => {
  ReactDOM.render(
    <AppContainer>
      <HashRouter>
        <Component />
      </HashRouter>
    </AppContainer>,
    document.getElementById('app'))
}

$(function() {
  initCapybaraSupport($)

  render(App)

  if (module.hot) {
    module.hot.accept("../src/js/app.js", () => {
      render(App)
    })
  }
})
