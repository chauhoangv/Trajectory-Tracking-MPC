// Auto-generated. Do not edit!

// (in-package utils.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Point2D = require('../msg/Point2D.js');

//-----------------------------------------------------------

let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class go_to_multipleRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.vrefName = null;
      this.x0 = null;
      this.y0 = null;
      this.yaw0 = null;
      this.destinations = null;
    }
    else {
      if (initObj.hasOwnProperty('vrefName')) {
        this.vrefName = initObj.vrefName
      }
      else {
        this.vrefName = '';
      }
      if (initObj.hasOwnProperty('x0')) {
        this.x0 = initObj.x0
      }
      else {
        this.x0 = 0.0;
      }
      if (initObj.hasOwnProperty('y0')) {
        this.y0 = initObj.y0
      }
      else {
        this.y0 = 0.0;
      }
      if (initObj.hasOwnProperty('yaw0')) {
        this.yaw0 = initObj.yaw0
      }
      else {
        this.yaw0 = 0.0;
      }
      if (initObj.hasOwnProperty('destinations')) {
        this.destinations = initObj.destinations
      }
      else {
        this.destinations = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type go_to_multipleRequest
    // Serialize message field [vrefName]
    bufferOffset = _serializer.string(obj.vrefName, buffer, bufferOffset);
    // Serialize message field [x0]
    bufferOffset = _serializer.float64(obj.x0, buffer, bufferOffset);
    // Serialize message field [y0]
    bufferOffset = _serializer.float64(obj.y0, buffer, bufferOffset);
    // Serialize message field [yaw0]
    bufferOffset = _serializer.float64(obj.yaw0, buffer, bufferOffset);
    // Serialize message field [destinations]
    // Serialize the length for message field [destinations]
    bufferOffset = _serializer.uint32(obj.destinations.length, buffer, bufferOffset);
    obj.destinations.forEach((val) => {
      bufferOffset = Point2D.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type go_to_multipleRequest
    let len;
    let data = new go_to_multipleRequest(null);
    // Deserialize message field [vrefName]
    data.vrefName = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [x0]
    data.x0 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y0]
    data.y0 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [yaw0]
    data.yaw0 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [destinations]
    // Deserialize array length for message field [destinations]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.destinations = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.destinations[i] = Point2D.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.vrefName);
    length += 8 * object.destinations.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a service object
    return 'utils/go_to_multipleRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f2759900116fce48a9130da8a42d76ae';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Request
    string vrefName
    float64 x0
    float64 y0
    float64 yaw0
    Point2D[] destinations
    
    ================================================================================
    MSG: utils/Point2D
    float32 x
    float32 y
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new go_to_multipleRequest(null);
    if (msg.vrefName !== undefined) {
      resolved.vrefName = msg.vrefName;
    }
    else {
      resolved.vrefName = ''
    }

    if (msg.x0 !== undefined) {
      resolved.x0 = msg.x0;
    }
    else {
      resolved.x0 = 0.0
    }

    if (msg.y0 !== undefined) {
      resolved.y0 = msg.y0;
    }
    else {
      resolved.y0 = 0.0
    }

    if (msg.yaw0 !== undefined) {
      resolved.yaw0 = msg.yaw0;
    }
    else {
      resolved.yaw0 = 0.0
    }

    if (msg.destinations !== undefined) {
      resolved.destinations = new Array(msg.destinations.length);
      for (let i = 0; i < resolved.destinations.length; ++i) {
        resolved.destinations[i] = Point2D.Resolve(msg.destinations[i]);
      }
    }
    else {
      resolved.destinations = []
    }

    return resolved;
    }
};

class go_to_multipleResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.state_refs = null;
      this.input_refs = null;
      this.wp_attributes = null;
      this.wp_normals = null;
    }
    else {
      if (initObj.hasOwnProperty('state_refs')) {
        this.state_refs = initObj.state_refs
      }
      else {
        this.state_refs = new std_msgs.msg.Float32MultiArray();
      }
      if (initObj.hasOwnProperty('input_refs')) {
        this.input_refs = initObj.input_refs
      }
      else {
        this.input_refs = new std_msgs.msg.Float32MultiArray();
      }
      if (initObj.hasOwnProperty('wp_attributes')) {
        this.wp_attributes = initObj.wp_attributes
      }
      else {
        this.wp_attributes = new std_msgs.msg.Float32MultiArray();
      }
      if (initObj.hasOwnProperty('wp_normals')) {
        this.wp_normals = initObj.wp_normals
      }
      else {
        this.wp_normals = new std_msgs.msg.Float32MultiArray();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type go_to_multipleResponse
    // Serialize message field [state_refs]
    bufferOffset = std_msgs.msg.Float32MultiArray.serialize(obj.state_refs, buffer, bufferOffset);
    // Serialize message field [input_refs]
    bufferOffset = std_msgs.msg.Float32MultiArray.serialize(obj.input_refs, buffer, bufferOffset);
    // Serialize message field [wp_attributes]
    bufferOffset = std_msgs.msg.Float32MultiArray.serialize(obj.wp_attributes, buffer, bufferOffset);
    // Serialize message field [wp_normals]
    bufferOffset = std_msgs.msg.Float32MultiArray.serialize(obj.wp_normals, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type go_to_multipleResponse
    let len;
    let data = new go_to_multipleResponse(null);
    // Deserialize message field [state_refs]
    data.state_refs = std_msgs.msg.Float32MultiArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [input_refs]
    data.input_refs = std_msgs.msg.Float32MultiArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [wp_attributes]
    data.wp_attributes = std_msgs.msg.Float32MultiArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [wp_normals]
    data.wp_normals = std_msgs.msg.Float32MultiArray.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Float32MultiArray.getMessageSize(object.state_refs);
    length += std_msgs.msg.Float32MultiArray.getMessageSize(object.input_refs);
    length += std_msgs.msg.Float32MultiArray.getMessageSize(object.wp_attributes);
    length += std_msgs.msg.Float32MultiArray.getMessageSize(object.wp_normals);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'utils/go_to_multipleResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0576e9a6b9512514425801361e4acb22';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Response
    std_msgs/Float32MultiArray state_refs
    std_msgs/Float32MultiArray input_refs
    std_msgs/Float32MultiArray wp_attributes
    std_msgs/Float32MultiArray wp_normals
    
    
    ================================================================================
    MSG: std_msgs/Float32MultiArray
    # Please look at the MultiArrayLayout message definition for
    # documentation on all multiarrays.
    
    MultiArrayLayout  layout        # specification of data layout
    float32[]         data          # array of data
    
    
    ================================================================================
    MSG: std_msgs/MultiArrayLayout
    # The multiarray declares a generic multi-dimensional array of a
    # particular data type.  Dimensions are ordered from outer most
    # to inner most.
    
    MultiArrayDimension[] dim # Array of dimension properties
    uint32 data_offset        # padding elements at front of data
    
    # Accessors should ALWAYS be written in terms of dimension stride
    # and specified outer-most dimension first.
    # 
    # multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
    #
    # A standard, 3-channel 640x480 image with interleaved color channels
    # would be specified as:
    #
    # dim[0].label  = "height"
    # dim[0].size   = 480
    # dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
    # dim[1].label  = "width"
    # dim[1].size   = 640
    # dim[1].stride = 3*640 = 1920
    # dim[2].label  = "channel"
    # dim[2].size   = 3
    # dim[2].stride = 3
    #
    # multiarray(i,j,k) refers to the ith row, jth column, and kth channel.
    
    ================================================================================
    MSG: std_msgs/MultiArrayDimension
    string label   # label of given dimension
    uint32 size    # size of given dimension (in type units)
    uint32 stride  # stride of given dimension
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new go_to_multipleResponse(null);
    if (msg.state_refs !== undefined) {
      resolved.state_refs = std_msgs.msg.Float32MultiArray.Resolve(msg.state_refs)
    }
    else {
      resolved.state_refs = new std_msgs.msg.Float32MultiArray()
    }

    if (msg.input_refs !== undefined) {
      resolved.input_refs = std_msgs.msg.Float32MultiArray.Resolve(msg.input_refs)
    }
    else {
      resolved.input_refs = new std_msgs.msg.Float32MultiArray()
    }

    if (msg.wp_attributes !== undefined) {
      resolved.wp_attributes = std_msgs.msg.Float32MultiArray.Resolve(msg.wp_attributes)
    }
    else {
      resolved.wp_attributes = new std_msgs.msg.Float32MultiArray()
    }

    if (msg.wp_normals !== undefined) {
      resolved.wp_normals = std_msgs.msg.Float32MultiArray.Resolve(msg.wp_normals)
    }
    else {
      resolved.wp_normals = new std_msgs.msg.Float32MultiArray()
    }

    return resolved;
    }
};

module.exports = {
  Request: go_to_multipleRequest,
  Response: go_to_multipleResponse,
  md5sum() { return '3e9590ffda7f3c098d288272e4eaaa2d'; },
  datatype() { return 'utils/go_to_multiple'; }
};
