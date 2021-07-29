// Auto-generated. Do not edit!

// (in-package darknet_ros_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class BoundingBox {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.probability = null;
      this.x_center = null;
      this.y_center = null;
      this.id = null;
      this.Class = null;
    }
    else {
      if (initObj.hasOwnProperty('probability')) {
        this.probability = initObj.probability
      }
      else {
        this.probability = 0.0;
      }
      if (initObj.hasOwnProperty('x_center')) {
        this.x_center = initObj.x_center
      }
      else {
        this.x_center = 0;
      }
      if (initObj.hasOwnProperty('y_center')) {
        this.y_center = initObj.y_center
      }
      else {
        this.y_center = 0;
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('Class')) {
        this.Class = initObj.Class
      }
      else {
        this.Class = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BoundingBox
    // Serialize message field [probability]
    bufferOffset = _serializer.float64(obj.probability, buffer, bufferOffset);
    // Serialize message field [x_center]
    bufferOffset = _serializer.int64(obj.x_center, buffer, bufferOffset);
    // Serialize message field [y_center]
    bufferOffset = _serializer.int64(obj.y_center, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int16(obj.id, buffer, bufferOffset);
    // Serialize message field [Class]
    bufferOffset = _serializer.string(obj.Class, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BoundingBox
    let len;
    let data = new BoundingBox(null);
    // Deserialize message field [probability]
    data.probability = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [x_center]
    data.x_center = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [y_center]
    data.y_center = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [Class]
    data.Class = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.Class.length;
    return length + 30;
  }

  static datatype() {
    // Returns string type for a message object
    return 'darknet_ros_msgs/BoundingBox';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5cb3788943fd45318c44a05b2f199b7a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 probability
    int64 x_center
    int64 y_center
    int16 id
    string Class
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BoundingBox(null);
    if (msg.probability !== undefined) {
      resolved.probability = msg.probability;
    }
    else {
      resolved.probability = 0.0
    }

    if (msg.x_center !== undefined) {
      resolved.x_center = msg.x_center;
    }
    else {
      resolved.x_center = 0
    }

    if (msg.y_center !== undefined) {
      resolved.y_center = msg.y_center;
    }
    else {
      resolved.y_center = 0
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.Class !== undefined) {
      resolved.Class = msg.Class;
    }
    else {
      resolved.Class = ''
    }

    return resolved;
    }
};

module.exports = BoundingBox;
