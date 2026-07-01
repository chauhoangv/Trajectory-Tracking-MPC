
"use strict";

let waypoints = require('./waypoints.js')
let go_to = require('./go_to.js')
let go_to_multiple = require('./go_to_multiple.js')
let set_states = require('./set_states.js')
let goto_command = require('./goto_command.js')

module.exports = {
  waypoints: waypoints,
  go_to: go_to,
  go_to_multiple: go_to_multiple,
  set_states: set_states,
  goto_command: goto_command,
};
