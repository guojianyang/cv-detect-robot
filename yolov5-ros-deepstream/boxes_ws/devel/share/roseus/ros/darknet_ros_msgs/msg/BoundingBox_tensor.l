;; Auto-generated. Do not edit!


(when (boundp 'darknet_ros_msgs::BoundingBox_tensor)
  (if (not (find-package "DARKNET_ROS_MSGS"))
    (make-package "DARKNET_ROS_MSGS"))
  (shadow 'BoundingBox_tensor (find-package "DARKNET_ROS_MSGS")))
(unless (find-package "DARKNET_ROS_MSGS::BOUNDINGBOX_TENSOR")
  (make-package "DARKNET_ROS_MSGS::BOUNDINGBOX_TENSOR"))

(in-package "ROS")
;;//! \htmlinclude BoundingBox_tensor.msg.html


(defclass darknet_ros_msgs::BoundingBox_tensor
  :super ros::object
  :slots (_probability _top _left _width _height _id _Class ))

(defmethod darknet_ros_msgs::BoundingBox_tensor
  (:init
   (&key
    ((:probability __probability) 0.0)
    ((:top __top) 0)
    ((:left __left) 0)
    ((:width __width) 0)
    ((:height __height) 0)
    ((:id __id) 0)
    ((:Class __Class) "")
    )
   (send-super :init)
   (setq _probability (float __probability))
   (setq _top (round __top))
   (setq _left (round __left))
   (setq _width (round __width))
   (setq _height (round __height))
   (setq _id (round __id))
   (setq _Class (string __Class))
   self)
  (:probability
   (&optional __probability)
   (if __probability (setq _probability __probability)) _probability)
  (:top
   (&optional __top)
   (if __top (setq _top __top)) _top)
  (:left
   (&optional __left)
   (if __left (setq _left __left)) _left)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
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
    ;; int64 _top
    8
    ;; int64 _left
    8
    ;; int64 _width
    8
    ;; int64 _height
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
     ;; int64 _top
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _top (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _top) (= (length (_top . bv)) 2)) ;; bignum
              (write-long (ash (elt (_top . bv) 0) 0) s)
              (write-long (ash (elt (_top . bv) 1) -1) s))
             ((and (class _top) (= (length (_top . bv)) 1)) ;; big1
              (write-long (elt (_top . bv) 0) s)
              (write-long (if (>= _top 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _top s)(write-long (if (>= _top 0) 0 #xffffffff) s)))
     ;; int64 _left
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _left (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _left) (= (length (_left . bv)) 2)) ;; bignum
              (write-long (ash (elt (_left . bv) 0) 0) s)
              (write-long (ash (elt (_left . bv) 1) -1) s))
             ((and (class _left) (= (length (_left . bv)) 1)) ;; big1
              (write-long (elt (_left . bv) 0) s)
              (write-long (if (>= _left 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _left s)(write-long (if (>= _left 0) 0 #xffffffff) s)))
     ;; int64 _width
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _width (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _width) (= (length (_width . bv)) 2)) ;; bignum
              (write-long (ash (elt (_width . bv) 0) 0) s)
              (write-long (ash (elt (_width . bv) 1) -1) s))
             ((and (class _width) (= (length (_width . bv)) 1)) ;; big1
              (write-long (elt (_width . bv) 0) s)
              (write-long (if (>= _width 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _width s)(write-long (if (>= _width 0) 0 #xffffffff) s)))
     ;; int64 _height
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _height (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _height) (= (length (_height . bv)) 2)) ;; bignum
              (write-long (ash (elt (_height . bv) 0) 0) s)
              (write-long (ash (elt (_height . bv) 1) -1) s))
             ((and (class _height) (= (length (_height . bv)) 1)) ;; big1
              (write-long (elt (_height . bv) 0) s)
              (write-long (if (>= _height 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _height s)(write-long (if (>= _height 0) 0 #xffffffff) s)))
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
   ;; int64 _top
#+(or :alpha :irix6 :x86_64)
      (setf _top (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _top (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _left
#+(or :alpha :irix6 :x86_64)
      (setf _left (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _left (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _width
#+(or :alpha :irix6 :x86_64)
      (setf _width (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _width (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _height
#+(or :alpha :irix6 :x86_64)
      (setf _height (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _height (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get darknet_ros_msgs::BoundingBox_tensor :md5sum-) "3404e61b484e6906df294d1085fb25b8")
(setf (get darknet_ros_msgs::BoundingBox_tensor :datatype-) "darknet_ros_msgs/BoundingBox_tensor")
(setf (get darknet_ros_msgs::BoundingBox_tensor :definition-)
      "float64 probability
int64 top
int64 left
int64 width
int64 height
int16 id
string Class

")



(provide :darknet_ros_msgs/BoundingBox_tensor "3404e61b484e6906df294d1085fb25b8")


