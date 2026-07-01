// Auto-generated. Do not edit!

// (in-package utils.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Lane3 {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.lane_center_offset = null;
      this.stopline_dist = null;
      this.stopline_angle = null;
      this.lane_waypoints = null;
      this.left_waypoints = null;
      this.right_waypoints = null;
      this.good_left = null;
      this.good_right = null;
      this.near_m = null;
      this.straight_lane = null;
      this.straight_lane_angle = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('lane_center_offset')) {
        this.lane_center_offset = initObj.lane_center_offset
      }
      else {
        this.lane_center_offset = 0.0;
      }
      if (initObj.hasOwnProperty('stopline_dist')) {
        this.stopline_dist = initObj.stopline_dist
      }
      else {
        this.stopline_dist = 0.0;
      }
      if (initObj.hasOwnProperty('stopline_angle')) {
        this.stopline_angle = initObj.stopline_angle
      }
      else {
        this.stopline_angle = 0.0;
      }
      if (initObj.hasOwnProperty('lane_waypoints')) {
        this.lane_waypoints = initObj.lane_waypoints
      }
      else {
        this.lane_waypoints = [];
      }
      if (initObj.hasOwnProperty('left_waypoints')) {
        this.left_waypoints = initObj.left_waypoints
      }
      else {
        this.left_waypoints = [];
      }
      if (initObj.hasOwnProperty('right_waypoints')) {
        this.right_waypoints = initObj.right_waypoints
      }
      else {
        this.right_waypoints = [];
      }
      if (initObj.hasOwnProperty('good_left')) {
        this.good_left = initObj.good_left
      }
      else {
        this.good_left = false;
      }
      if (initObj.hasOwnProperty('good_right')) {
        this.good_right = initObj.good_right
      }
      else {
        this.good_right = false;
      }
      if (initObj.hasOwnProperty('near_m')) {
        this.near_m = initObj.near_m
      }
      else {
        this.near_m = 0.0;
      }
      if (initObj.hasOwnProperty('straight_lane')) {
        this.straight_lane = initObj.straight_lane
      }
      else {
        this.straight_lane = false;
      }
      if (initObj.hasOwnProperty('straight_lane_angle')) {
        this.straight_lane_angle = initObj.straight_lane_angle
      }
      else {
        this.straight_lane_angle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Lane3
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [lane_center_offset]
    bufferOffset = _serializer.float32(obj.lane_center_offset, buffer, bufferOffset);
    // Serialize message field [stopline_dist]
    bufferOffset = _serializer.float32(obj.stopline_dist, buffer, bufferOffset);
    // Serialize message field [stopline_angle]
    bufferOffset = _serializer.float32(obj.stopline_angle, buffer, bufferOffset);
    // Serialize message field [lane_waypoints]
    bufferOffset = _arraySerializer.float32(obj.lane_waypoints, buffer, bufferOffset, null);
    // Serialize message field [left_waypoints]
    bufferOffset = _arraySerializer.float32(obj.left_waypoints, buffer, bufferOffset, null);
    // Serialize message field [right_waypoints]
    bufferOffset = _arraySerializer.float32(obj.right_waypoints, buffer, bufferOffset, null);
    // Serialize message field [good_left]
    bufferOffset = _serializer.bool(obj.good_left, buffer, bufferOffset);
    // Serialize message field [good_right]
    bufferOffset = _serializer.bool(obj.good_right, buffer, bufferOffset);
    // Serialize message field [near_m]
    bufferOffset = _serializer.float32(obj.near_m, buffer, bufferOffset);
    // Serialize message field [straight_lane]
    bufferOffset = _serializer.bool(obj.straight_lane, buffer, bufferOffset);
    // Serialize message field [straight_lane_angle]
    bufferOffset = _serializer.float32(obj.straight_lane_angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Lane3
    let len;
    let data = new Lane3(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [lane_center_offset]
    data.lane_center_offset = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [stopline_dist]
    data.stopline_dist = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [stopline_angle]
    data.stopline_angle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lane_waypoints]
    data.lane_waypoints = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [left_waypoints]
    data.left_waypoints = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [right_waypoints]
    data.right_waypoints = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [good_left]
    data.good_left = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [good_right]
    data.good_right = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [near_m]
    data.near_m = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [straight_lane]
    data.straight_lane = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [straight_lane_angle]
    data.straight_lane_angle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.lane_waypoints.length;
    length += 4 * object.left_waypoints.length;
    length += 4 * object.right_waypoints.length;
    return length + 35;
  }

  static datatype() {
    // Returns string type for a message object
    return 'utils/Lane3';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7cd779cc732881430cec77cebbd3b445';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    float32 lane_center_offset
    float32 stopline_dist
    float32 stopline_angle
    float32[] lane_waypoints
    float32[] left_waypoints
    float32[] right_waypoints
    bool good_left
    bool good_right
    float32 near_m
    bool straight_lane
    float32 straight_lane_angle
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Lane3(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.lane_center_offset !== undefined) {
      resolved.lane_center_offset = msg.lane_center_offset;
    }
    else {
      resolved.lane_center_offset = 0.0
    }

    if (msg.stopline_dist !== undefined) {
      resolved.stopline_dist = msg.stopline_dist;
    }
    else {
      resolved.stopline_dist = 0.0
    }

    if (msg.stopline_angle !== undefined) {
      resolved.stopline_angle = msg.stopline_angle;
    }
    else {
      resolved.stopline_angle = 0.0
    }

    if (msg.lane_waypoints !== undefined) {
      resolved.lane_waypoints = msg.lane_waypoints;
    }
    else {
      resolved.lane_waypoints = []
    }

    if (msg.left_waypoints !== undefined) {
      resolved.left_waypoints = msg.left_waypoints;
    }
    else {
      resolved.left_waypoints = []
    }

    if (msg.right_waypoints !== undefined) {
      resolved.right_waypoints = msg.right_waypoints;
    }
    else {
      resolved.right_waypoints = []
    }

    if (msg.good_left !== undefined) {
      resolved.good_left = msg.good_left;
    }
    else {
      resolved.good_left = false
    }

    if (msg.good_right !== undefined) {
      resolved.good_right = msg.good_right;
    }
    else {
      resolved.good_right = false
    }

    if (msg.near_m !== undefined) {
      resolved.near_m = msg.near_m;
    }
    else {
      resolved.near_m = 0.0
    }

    if (msg.straight_lane !== undefined) {
      resolved.straight_lane = msg.straight_lane;
    }
    else {
      resolved.straight_lane = false
    }

    if (msg.straight_lane_angle !== undefined) {
      resolved.straight_lane_angle = msg.straight_lane_angle;
    }
    else {
      resolved.straight_lane_angle = 0.0
    }

    return resolved;
    }
};

module.exports = Lane3;
