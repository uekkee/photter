import Rails from "@rails/ujs"
import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'
import '@stimulus/polyfills'
import 'lazysizes'

import "./css/application.scss"

import '@fortawesome/fontawesome-free/js/fontawesome'
import '@fortawesome/fontawesome-free/js/solid'

const application = Application.start()
const context = require.context('./controllers', true, /^\.\/.*\.js$/)
application.load(definitionsFromContext(context))

Rails.start()
