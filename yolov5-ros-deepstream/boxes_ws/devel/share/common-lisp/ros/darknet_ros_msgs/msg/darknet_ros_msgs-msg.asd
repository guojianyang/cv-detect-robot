
(cl:in-package :asdf)

(defsystem "darknet_ros_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "BoundingBox" :depends-on ("_package_BoundingBox"))
    (:file "_package_BoundingBox" :depends-on ("_package"))
    (:file "BoundingBox_tensor" :depends-on ("_package_BoundingBox_tensor"))
    (:file "_package_BoundingBox_tensor" :depends-on ("_package"))
    (:file "BoundingBoxes" :depends-on ("_package_BoundingBoxes"))
    (:file "_package_BoundingBoxes" :depends-on ("_package"))
    (:file "BoundingBoxes_tensor" :depends-on ("_package_BoundingBoxes_tensor"))
    (:file "_package_BoundingBoxes_tensor" :depends-on ("_package"))
  ))