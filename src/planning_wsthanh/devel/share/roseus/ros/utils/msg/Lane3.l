;; Auto-generated. Do not edit!


(when (boundp 'utils::Lane3)
  (if (not (find-package "UTILS"))
    (make-package "UTILS"))
  (shadow 'Lane3 (find-package "UTILS")))
(unless (find-package "UTILS::LANE3")
  (make-package "UTILS::LANE3"))

(in-package "ROS")
;;//! \htmlinclude Lane3.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass utils::Lane3
  :super ros::object
  :slots (_header _lane_center_offset _stopline_dist _stopline_angle _lane_waypoints _left_waypoints _right_waypoints _good_left _good_right _near_m _straight_lane _straight_lane_angle ))

(defmethod utils::Lane3
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:lane_center_offset __lane_center_offset) 0.0)
    ((:stopline_dist __stopline_dist) 0.0)
    ((:stopline_angle __stopline_angle) 0.0)
    ((:lane_waypoints __lane_waypoints) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:left_waypoints __left_waypoints) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:right_waypoints __right_waypoints) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:good_left __good_left) nil)
    ((:good_right __good_right) nil)
    ((:near_m __near_m) 0.0)
    ((:straight_lane __straight_lane) nil)
    ((:straight_lane_angle __straight_lane_angle) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _lane_center_offset (float __lane_center_offset))
   (setq _stopline_dist (float __stopline_dist))
   (setq _stopline_angle (float __stopline_angle))
   (setq _lane_waypoints __lane_waypoints)
   (setq _left_waypoints __left_waypoints)
   (setq _right_waypoints __right_waypoints)
   (setq _good_left __good_left)
   (setq _good_right __good_right)
   (setq _near_m (float __near_m))
   (setq _straight_lane __straight_lane)
   (setq _straight_lane_angle (float __straight_lane_angle))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:lane_center_offset
   (&optional __lane_center_offset)
   (if __lane_center_offset (setq _lane_center_offset __lane_center_offset)) _lane_center_offset)
  (:stopline_dist
   (&optional __stopline_dist)
   (if __stopline_dist (setq _stopline_dist __stopline_dist)) _stopline_dist)
  (:stopline_angle
   (&optional __stopline_angle)
   (if __stopline_angle (setq _stopline_angle __stopline_angle)) _stopline_angle)
  (:lane_waypoints
   (&optional __lane_waypoints)
   (if __lane_waypoints (setq _lane_waypoints __lane_waypoints)) _lane_waypoints)
  (:left_waypoints
   (&optional __left_waypoints)
   (if __left_waypoints (setq _left_waypoints __left_waypoints)) _left_waypoints)
  (:right_waypoints
   (&optional __right_waypoints)
   (if __right_waypoints (setq _right_waypoints __right_waypoints)) _right_waypoints)
  (:good_left
   (&optional (__good_left :null))
   (if (not (eq __good_left :null)) (setq _good_left __good_left)) _good_left)
  (:good_right
   (&optional (__good_right :null))
   (if (not (eq __good_right :null)) (setq _good_right __good_right)) _good_right)
  (:near_m
   (&optional __near_m)
   (if __near_m (setq _near_m __near_m)) _near_m)
  (:straight_lane
   (&optional (__straight_lane :null))
   (if (not (eq __straight_lane :null)) (setq _straight_lane __straight_lane)) _straight_lane)
  (:straight_lane_angle
   (&optional __straight_lane_angle)
   (if __straight_lane_angle (setq _straight_lane_angle __straight_lane_angle)) _straight_lane_angle)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _lane_center_offset
    4
    ;; float32 _stopline_dist
    4
    ;; float32 _stopline_angle
    4
    ;; float32[] _lane_waypoints
    (* 4    (length _lane_waypoints)) 4
    ;; float32[] _left_waypoints
    (* 4    (length _left_waypoints)) 4
    ;; float32[] _right_waypoints
    (* 4    (length _right_waypoints)) 4
    ;; bool _good_left
    1
    ;; bool _good_right
    1
    ;; float32 _near_m
    4
    ;; bool _straight_lane
    1
    ;; float32 _straight_lane_angle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _lane_center_offset
       (sys::poke _lane_center_offset (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _stopline_dist
       (sys::poke _stopline_dist (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _stopline_angle
       (sys::poke _stopline_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _lane_waypoints
     (write-long (length _lane_waypoints) s)
     (dotimes (i (length _lane_waypoints))
       (sys::poke (elt _lane_waypoints i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _left_waypoints
     (write-long (length _left_waypoints) s)
     (dotimes (i (length _left_waypoints))
       (sys::poke (elt _left_waypoints i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _right_waypoints
     (write-long (length _right_waypoints) s)
     (dotimes (i (length _right_waypoints))
       (sys::poke (elt _right_waypoints i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; bool _good_left
       (if _good_left (write-byte -1 s) (write-byte 0 s))
     ;; bool _good_right
       (if _good_right (write-byte -1 s) (write-byte 0 s))
     ;; float32 _near_m
       (sys::poke _near_m (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _straight_lane
       (if _straight_lane (write-byte -1 s) (write-byte 0 s))
     ;; float32 _straight_lane_angle
       (sys::poke _straight_lane_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _lane_center_offset
     (setq _lane_center_offset (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _stopline_dist
     (setq _stopline_dist (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _stopline_angle
     (setq _stopline_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _lane_waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lane_waypoints (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _lane_waypoints i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _left_waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _left_waypoints (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _left_waypoints i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _right_waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _right_waypoints (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _right_waypoints i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; bool _good_left
     (setq _good_left (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _good_right
     (setq _good_right (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _near_m
     (setq _near_m (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _straight_lane
     (setq _straight_lane (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _straight_lane_angle
     (setq _straight_lane_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get utils::Lane3 :md5sum-) "7cd779cc732881430cec77cebbd3b445")
(setf (get utils::Lane3 :datatype-) "utils/Lane3")
(setf (get utils::Lane3 :definition-)
      "std_msgs/Header header

float32 lane_center_offset
float32 stopline_dist
float32 stopline_angle
float32[] lane_waypoints
float32[] left_waypoints
float32[] right_waypoints
bool good_left
bool good_right
float32 near_m
bool straight_lane
float32 straight_lane_angle
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



(provide :utils/Lane3 "7cd779cc732881430cec77cebbd3b445")


