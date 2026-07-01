;; Auto-generated. Do not edit!


(when (boundp 'utils::Lane)
  (if (not (find-package "UTILS"))
    (make-package "UTILS"))
  (shadow 'Lane (find-package "UTILS")))
(unless (find-package "UTILS::LANE")
  (make-package "UTILS::LANE"))

(in-package "ROS")
;;//! \htmlinclude Lane.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass utils::Lane
  :super ros::object
  :slots (_header _center _stopline _crosswalk ))

(defmethod utils::Lane
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:center __center) 0.0)
    ((:stopline __stopline) nil)
    ((:crosswalk __crosswalk) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _center (float __center))
   (setq _stopline __stopline)
   (setq _crosswalk __crosswalk)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:center
   (&optional __center)
   (if __center (setq _center __center)) _center)
  (:stopline
   (&optional (__stopline :null))
   (if (not (eq __stopline :null)) (setq _stopline __stopline)) _stopline)
  (:crosswalk
   (&optional (__crosswalk :null))
   (if (not (eq __crosswalk :null)) (setq _crosswalk __crosswalk)) _crosswalk)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _center
    4
    ;; bool _stopline
    1
    ;; bool _crosswalk
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _center
       (sys::poke _center (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _stopline
       (if _stopline (write-byte -1 s) (write-byte 0 s))
     ;; bool _crosswalk
       (if _crosswalk (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _center
     (setq _center (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _stopline
     (setq _stopline (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _crosswalk
     (setq _crosswalk (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get utils::Lane :md5sum-) "9b09acf3f04ae4812083cc2e198f42df")
(setf (get utils::Lane :datatype-) "utils/Lane")
(setf (get utils::Lane :definition-)
      "std_msgs/Header header

float32 center
bool stopline
bool crosswalk
# bool dotted
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

")



(provide :utils/Lane "9b09acf3f04ae4812083cc2e198f42df")


