; Auto-generated. Do not edit!


(cl:in-package darknet_ros_msgs-msg)


;//! \htmlinclude BoundingBoxes_tensor.msg.html

(cl:defclass <BoundingBoxes_tensor> (roslisp-msg-protocol:ros-message)
  ((boundingboxes_tensor
    :reader boundingboxes_tensor
    :initarg :boundingboxes_tensor
    :type (cl:vector darknet_ros_msgs-msg:BoundingBox_tensor)
   :initform (cl:make-array 0 :element-type 'darknet_ros_msgs-msg:BoundingBox_tensor :initial-element (cl:make-instance 'darknet_ros_msgs-msg:BoundingBox_tensor))))
)

(cl:defclass BoundingBoxes_tensor (<BoundingBoxes_tensor>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BoundingBoxes_tensor>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BoundingBoxes_tensor)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name darknet_ros_msgs-msg:<BoundingBoxes_tensor> is deprecated: use darknet_ros_msgs-msg:BoundingBoxes_tensor instead.")))

(cl:ensure-generic-function 'boundingboxes_tensor-val :lambda-list '(m))
(cl:defmethod boundingboxes_tensor-val ((m <BoundingBoxes_tensor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader darknet_ros_msgs-msg:boundingboxes_tensor-val is deprecated.  Use darknet_ros_msgs-msg:boundingboxes_tensor instead.")
  (boundingboxes_tensor m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BoundingBoxes_tensor>) ostream)
  "Serializes a message object of type '<BoundingBoxes_tensor>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'boundingboxes_tensor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'boundingboxes_tensor))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BoundingBoxes_tensor>) istream)
  "Deserializes a message object of type '<BoundingBoxes_tensor>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'boundingboxes_tensor) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'boundingboxes_tensor)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'darknet_ros_msgs-msg:BoundingBox_tensor))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BoundingBoxes_tensor>)))
  "Returns string type for a message object of type '<BoundingBoxes_tensor>"
  "darknet_ros_msgs/BoundingBoxes_tensor")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BoundingBoxes_tensor)))
  "Returns string type for a message object of type 'BoundingBoxes_tensor"
  "darknet_ros_msgs/BoundingBoxes_tensor")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BoundingBoxes_tensor>)))
  "Returns md5sum for a message object of type '<BoundingBoxes_tensor>"
  "28b99bb7e3f0d3196525501e81626006")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BoundingBoxes_tensor)))
  "Returns md5sum for a message object of type 'BoundingBoxes_tensor"
  "28b99bb7e3f0d3196525501e81626006")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BoundingBoxes_tensor>)))
  "Returns full string definition for message of type '<BoundingBoxes_tensor>"
  (cl:format cl:nil "BoundingBox_tensor[] boundingboxes_tensor~%~%================================================================================~%MSG: darknet_ros_msgs/BoundingBox_tensor~%float64 probability~%int64 top~%int64 left~%int64 width~%int64 height~%int16 id~%string Class~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BoundingBoxes_tensor)))
  "Returns full string definition for message of type 'BoundingBoxes_tensor"
  (cl:format cl:nil "BoundingBox_tensor[] boundingboxes_tensor~%~%================================================================================~%MSG: darknet_ros_msgs/BoundingBox_tensor~%float64 probability~%int64 top~%int64 left~%int64 width~%int64 height~%int16 id~%string Class~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BoundingBoxes_tensor>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'boundingboxes_tensor) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BoundingBoxes_tensor>))
  "Converts a ROS message object to a list"
  (cl:list 'BoundingBoxes_tensor
    (cl:cons ':boundingboxes_tensor (boundingboxes_tensor msg))
))
