// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"
window.$ = window.jQuery = require('jquery');

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MaskInput from "./mask_input"
application.register("mask_input", MaskInput)

import navBarMobileController from "./navbar_mobile_controller"
application.register("navbar_mobile", navBarMobileController)
