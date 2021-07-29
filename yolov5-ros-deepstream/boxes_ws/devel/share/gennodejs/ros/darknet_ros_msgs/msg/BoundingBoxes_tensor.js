// Auto-generated. Do not edit!

// (in-package darknet_ros_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let BoundingBox_tensor = require('./BoundingBox_tensor.js');

//-----------------------------------------------------------

class BoundingBoxes_tensor {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.boundingboxes_tensor = null;
    }
    else {
      if (initObj.hasOwnProperty('boundingboxes_tensor')) {
        this.boundingboxes_tensor = initObj.boundingboxes_tensor
      }
      else {
        this.boundingboxes_tensor = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BoundingBoxes_tensor
    // Serialize message field [boundingboxes_tensor]
    // Serialize the length for message field [boundingboxes_tensor]
    bufferOffset = _serializer.uint32(obj.boundingboxes_tensor.length, buffer, bufferOffset);
    obj.boundingboxes_tensor.forEach((val) => {
      bufferOffset = BoundingBox_tensor.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BoundingBoxes_tensor
    let len;
    let data = new BoundingBoxes_tensor(null);
    // Deserialize message field [boundingboxes_tensor]
    // Deserialize array length for message field [boundingboxes_tensor]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.boundingboxes_tensor = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.boundingboxes_tensor[i] = BoundingBox_tensor.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.boundingboxes_tensor.forEach((val) => {
      length += BoundingBox_tensor.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'darknet_ros_msgs/BoundingBoxes_tensor';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '28b99bb7e3f0d3196525501e81626006';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    BoundingBox_tensor[] boundingboxes_tensor
    
    ================================================================================
    MSG: darknet_ros_msgs/BoundingBox_tensor
    float64 probability
    int64 top
    int64 left
    int64 width
    int64 height
    int16 id
    string Class
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BoundingBoxes_tensor(null);
    if (msg.boundingboxes_tensor !== undefined) {
      resolved.boundingboxes_tensor = new Array(msg.boundingboxes_tensor.length);
      for (let i = 0; i < resolved.boundingboxes_tensor.length; ++i) {
        resolved.boundingboxes_tensor[i] = BoundingBox_tensor.Resolve(msg.boundingboxes_tensor[i]);
      }
    }
    else {
      resolved.boundingboxes_tensor = []
    }

    return resolved;
    }
};

module.exports = BoundingBoxes_tensor;
