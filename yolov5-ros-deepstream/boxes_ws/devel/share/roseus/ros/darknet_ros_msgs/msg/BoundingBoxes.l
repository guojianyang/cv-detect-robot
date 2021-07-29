;; Auto-generated. Do not edit!


(when (boundp 'darknet_ros_msgs::BoundingBoxes)
  (if (not (find-package "DARKNET_ROS_MSGS"))
    (make-package "DARKNET_ROS_MSGS"))
  (shadow 'BoundingBoxes (find-package "DARKNET_ROS_MSGS")))
(unless (find-package "DARKNET_ROS_MSGS::BOUNDINGBOXES")
  (make-package "DARKNET_ROS_MSGS::BOUNDINGBOXES"))

(in-package "ROS")
;;//! \htmlinclude BoundingBoxes.msg.html


(defclass darknet_ros_msgs::BoundingBoxes
  :super ros::object
  :slots (_bounding_boxes ))

(defmethod darknet_ros_msgs::BoundingBoxes
  (:init
   (&key
    ((:bounding_boxes __bounding_boxes) (let (r) (dotimes (i 0) (push (instance darknet_ros_msgs::BoundingBox :init) r)) r))
    )
   (send-super :init)
   (setq _bounding_boxes __bounding_boxes)
   self)
  (:bounding_boxes
   (&rest __bounding_boxes)
   (if (keywordp (car __bounding_boxes))
       (send* _bounding_boxes __bounding_boxes)
     (progn
       (if __bounding_boxes (setq _bounding_boxes (car __bounding_boxes)))
       _bounding_boxes)))
  (:serialization-length
   ()
   (+
    ;; darknet_ros_msgs/BoundingBox[] _bounding_boxes
    (apply #'+ (send-all _bounding_boxes :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; darknet_ros_msgs/BoundingBox[] _bounding_boxes
     (write-long (length _bounding_boxes) s)
     (dolist (elem _bounding_boxes)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; darknet_ros_msgs/BoundingBox[] _bounding_boxes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _bounding_boxes (let (r) (dotimes (i n) (push (instance darknet_ros_msgs::BoundingBox :init) r)) r))
     (dolist (elem- _bounding_boxes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get darknet_ros_msgs::BoundingBoxes :md5sum-) "5ad1f51c26570ed49518cddee07976c7")
(setf (get darknet_ros_msgs::BoundingBoxes :datatype-) "darknet_ros_msgs/BoundingBoxes")
(setf (get darknet_ros_msgs::BoundingBoxes :definition-)
      "BoundingBox[] bounding_boxes

================================================================================
MSG: darknet_ros_msgs/BoundingBox
float64 probability
int64 x_center
int64 y_center
int16 id
string Class

")



(provide :darknet_ros_msgs/BoundingBoxes "5ad1f51c26570ed49518cddee07976c7")


