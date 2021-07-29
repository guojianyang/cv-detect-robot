;; Auto-generated. Do not edit!


(when (boundp 'darknet_ros_msgs::BoundingBoxes_tensor)
  (if (not (find-package "DARKNET_ROS_MSGS"))
    (make-package "DARKNET_ROS_MSGS"))
  (shadow 'BoundingBoxes_tensor (find-package "DARKNET_ROS_MSGS")))
(unless (find-package "DARKNET_ROS_MSGS::BOUNDINGBOXES_TENSOR")
  (make-package "DARKNET_ROS_MSGS::BOUNDINGBOXES_TENSOR"))

(in-package "ROS")
;;//! \htmlinclude BoundingBoxes_tensor.msg.html


(defclass darknet_ros_msgs::BoundingBoxes_tensor
  :super ros::object
  :slots (_boundingboxes_tensor ))

(defmethod darknet_ros_msgs::BoundingBoxes_tensor
  (:init
   (&key
    ((:boundingboxes_tensor __boundingboxes_tensor) (let (r) (dotimes (i 0) (push (instance darknet_ros_msgs::BoundingBox_tensor :init) r)) r))
    )
   (send-super :init)
   (setq _boundingboxes_tensor __boundingboxes_tensor)
   self)
  (:boundingboxes_tensor
   (&rest __boundingboxes_tensor)
   (if (keywordp (car __boundingboxes_tensor))
       (send* _boundingboxes_tensor __boundingboxes_tensor)
     (progn
       (if __boundingboxes_tensor (setq _boundingboxes_tensor (car __boundingboxes_tensor)))
       _boundingboxes_tensor)))
  (:serialization-length
   ()
   (+
    ;; darknet_ros_msgs/BoundingBox_tensor[] _boundingboxes_tensor
    (apply #'+ (send-all _boundingboxes_tensor :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; darknet_ros_msgs/BoundingBox_tensor[] _boundingboxes_tensor
     (write-long (length _boundingboxes_tensor) s)
     (dolist (elem _boundingboxes_tensor)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; darknet_ros_msgs/BoundingBox_tensor[] _boundingboxes_tensor
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _boundingboxes_tensor (let (r) (dotimes (i n) (push (instance darknet_ros_msgs::BoundingBox_tensor :init) r)) r))
     (dolist (elem- _boundingboxes_tensor)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get darknet_ros_msgs::BoundingBoxes_tensor :md5sum-) "28b99bb7e3f0d3196525501e81626006")
(setf (get darknet_ros_msgs::BoundingBoxes_tensor :datatype-) "darknet_ros_msgs/BoundingBoxes_tensor")
(setf (get darknet_ros_msgs::BoundingBoxes_tensor :definition-)
      "BoundingBox_tensor[] boundingboxes_tensor

================================================================================
MSG: darknet_ros_msgs/BoundingBox_tensor
float64 probability
int64 top
int64 left
int64 width
int64 height
int16 id
string Class

")



(provide :darknet_ros_msgs/BoundingBoxes_tensor "28b99bb7e3f0d3196525501e81626006")


