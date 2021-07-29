;; Auto-generated. Do not edit!


(when (boundp 'darknet_ros_msgs::BoundingBox)
  (if (not (find-package "DARKNET_ROS_MSGS"))
    (make-package "DARKNET_ROS_MSGS"))
  (shadow 'BoundingBox (find-package "DARKNET_ROS_MSGS")))
(unless (find-package "DARKNET_ROS_MSGS::BOUNDINGBOX")
  (make-package "DARKNET_ROS_MSGS::BOUNDINGBOX"))

(in-package "ROS")
;;//! \htmlinclude BoundingBox.msg.html


(defclass darknet_ros_msgs::BoundingBox
  :super ros::object
  :slots (_probability _x_center _y_center _id _Class ))

(defmethod darknet_ros_msgs::BoundingBox
  (:init
   (&key
    ((:probability __probability) 0.0)
    ((:x_center __x_center) 0)
    ((:y_center __y_center) 0)
    ((:id __id) 0)
    ((:Class __Class) "")
    )
   (send-super :init)
   (setq _probability (float __probability))
   (setq _x_center (round __x_center))
   (setq _y_center (round __y_center))
   (setq _id (round __id))
   (setq _Class (string __Class))
   self)
  (:probability
   (&optional __probability)
   (if __probability (setq _probability __probability)) _probability)
  (:x_center
   (&optional __x_center)
   (if __x_center (setq _x_center __x_center)) _x_center)
  (:y_center
   (&optional __y_center)
   (if __y_center (setq _y_center __y_center)) _y_center)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:Class
   (&optional __Class)
   (if __Class (setq _Class __Class)) _Class)
  (:serialization-length
   ()
   (+
    ;; float64 _probability
    8
    ;; int64 _x_center
    8
    ;; int64 _y_center
    8
    ;; int16 _id
    2
    ;; string _Class
    4 (length _Class)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _probability
       (sys::poke _probability (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _x_center
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _x_center (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _x_center) (= (length (_x_center . bv)) 2)) ;; bignum
              (write-long (ash (elt (_x_center . bv) 0) 0) s)
              (write-long (ash (elt (_x_center . bv) 1) -1) s))
             ((and (class _x_center) (= (length (_x_center . bv)) 1)) ;; big1
              (write-long (elt (_x_center . bv) 0) s)
              (write-long (if (>= _x_center 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _x_center s)(write-long (if (>= _x_center 0) 0 #xffffffff) s)))
     ;; int64 _y_center
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _y_center (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _y_center) (= (length (_y_center . bv)) 2)) ;; bignum
              (write-long (ash (elt (_y_center . bv) 0) 0) s)
              (write-long (ash (elt (_y_center . bv) 1) -1) s))
             ((and (class _y_center) (= (length (_y_center . bv)) 1)) ;; big1
              (write-long (elt (_y_center . bv) 0) s)
              (write-long (if (>= _y_center 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _y_center s)(write-long (if (>= _y_center 0) 0 #xffffffff) s)))
     ;; int16 _id
       (write-word _id s)
     ;; string _Class
       (write-long (length _Class) s) (princ _Class s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _probability
     (setq _probability (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _x_center
#+(or :alpha :irix6 :x86_64)
      (setf _x_center (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _x_center (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _y_center
#+(or :alpha :irix6 :x86_64)
      (setf _y_center (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _y_center (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int16 _id
     (setq _id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; string _Class
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _Class (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get darknet_ros_msgs::BoundingBox :md5sum-) "5cb3788943fd45318c44a05b2f199b7a")
(setf (get darknet_ros_msgs::BoundingBox :datatype-) "darknet_ros_msgs/BoundingBox")
(setf (get darknet_ros_msgs::BoundingBox :definition-)
      "float64 probability
int64 x_center
int64 y_center
int16 id
string Class

")



(provide :darknet_ros_msgs/BoundingBox "5cb3788943fd45318c44a05b2f199b7a")


