; Auto-generated. Do not edit!


(cl:in-package utils-msg)


;//! \htmlinclude Lane3.msg.html

(cl:defclass <Lane3> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (lane_center_offset
    :reader lane_center_offset
    :initarg :lane_center_offset
    :type cl:float
    :initform 0.0)
   (stopline_dist
    :reader stopline_dist
    :initarg :stopline_dist
    :type cl:float
    :initform 0.0)
   (stopline_angle
    :reader stopline_angle
    :initarg :stopline_angle
    :type cl:float
    :initform 0.0)
   (lane_waypoints
    :reader lane_waypoints
    :initarg :lane_waypoints
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (left_waypoints
    :reader left_waypoints
    :initarg :left_waypoints
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (right_waypoints
    :reader right_waypoints
    :initarg :right_waypoints
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (good_left
    :reader good_left
    :initarg :good_left
    :type cl:boolean
    :initform cl:nil)
   (good_right
    :reader good_right
    :initarg :good_right
    :type cl:boolean
    :initform cl:nil)
   (near_m
    :reader near_m
    :initarg :near_m
    :type cl:float
    :initform 0.0)
   (straight_lane
    :reader straight_lane
    :initarg :straight_lane
    :type cl:boolean
    :initform cl:nil)
   (straight_lane_angle
    :reader straight_lane_angle
    :initarg :straight_lane_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass Lane3 (<Lane3>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Lane3>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Lane3)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-msg:<Lane3> is deprecated: use utils-msg:Lane3 instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:header-val is deprecated.  Use utils-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'lane_center_offset-val :lambda-list '(m))
(cl:defmethod lane_center_offset-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:lane_center_offset-val is deprecated.  Use utils-msg:lane_center_offset instead.")
  (lane_center_offset m))

(cl:ensure-generic-function 'stopline_dist-val :lambda-list '(m))
(cl:defmethod stopline_dist-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:stopline_dist-val is deprecated.  Use utils-msg:stopline_dist instead.")
  (stopline_dist m))

(cl:ensure-generic-function 'stopline_angle-val :lambda-list '(m))
(cl:defmethod stopline_angle-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:stopline_angle-val is deprecated.  Use utils-msg:stopline_angle instead.")
  (stopline_angle m))

(cl:ensure-generic-function 'lane_waypoints-val :lambda-list '(m))
(cl:defmethod lane_waypoints-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:lane_waypoints-val is deprecated.  Use utils-msg:lane_waypoints instead.")
  (lane_waypoints m))

(cl:ensure-generic-function 'left_waypoints-val :lambda-list '(m))
(cl:defmethod left_waypoints-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:left_waypoints-val is deprecated.  Use utils-msg:left_waypoints instead.")
  (left_waypoints m))

(cl:ensure-generic-function 'right_waypoints-val :lambda-list '(m))
(cl:defmethod right_waypoints-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:right_waypoints-val is deprecated.  Use utils-msg:right_waypoints instead.")
  (right_waypoints m))

(cl:ensure-generic-function 'good_left-val :lambda-list '(m))
(cl:defmethod good_left-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:good_left-val is deprecated.  Use utils-msg:good_left instead.")
  (good_left m))

(cl:ensure-generic-function 'good_right-val :lambda-list '(m))
(cl:defmethod good_right-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:good_right-val is deprecated.  Use utils-msg:good_right instead.")
  (good_right m))

(cl:ensure-generic-function 'near_m-val :lambda-list '(m))
(cl:defmethod near_m-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:near_m-val is deprecated.  Use utils-msg:near_m instead.")
  (near_m m))

(cl:ensure-generic-function 'straight_lane-val :lambda-list '(m))
(cl:defmethod straight_lane-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:straight_lane-val is deprecated.  Use utils-msg:straight_lane instead.")
  (straight_lane m))

(cl:ensure-generic-function 'straight_lane_angle-val :lambda-list '(m))
(cl:defmethod straight_lane_angle-val ((m <Lane3>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-msg:straight_lane_angle-val is deprecated.  Use utils-msg:straight_lane_angle instead.")
  (straight_lane_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Lane3>) ostream)
  "Serializes a message object of type '<Lane3>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'lane_center_offset))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'stopline_dist))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'stopline_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lane_waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'lane_waypoints))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'left_waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'left_waypoints))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'right_waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'right_waypoints))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'good_left) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'good_right) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'near_m))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'straight_lane) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'straight_lane_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Lane3>) istream)
  "Deserializes a message object of type '<Lane3>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'lane_center_offset) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'stopline_dist) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'stopline_angle) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lane_waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lane_waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'left_waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'left_waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'right_waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'right_waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:slot-value msg 'good_left) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'good_right) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'near_m) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'straight_lane) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'straight_lane_angle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Lane3>)))
  "Returns string type for a message object of type '<Lane3>"
  "utils/Lane3")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Lane3)))
  "Returns string type for a message object of type 'Lane3"
  "utils/Lane3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Lane3>)))
  "Returns md5sum for a message object of type '<Lane3>"
  "7cd779cc732881430cec77cebbd3b445")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Lane3)))
  "Returns md5sum for a message object of type 'Lane3"
  "7cd779cc732881430cec77cebbd3b445")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Lane3>)))
  "Returns full string definition for message of type '<Lane3>"
  (cl:format cl:nil "std_msgs/Header header~%~%float32 lane_center_offset~%float32 stopline_dist~%float32 stopline_angle~%float32[] lane_waypoints~%float32[] left_waypoints~%float32[] right_waypoints~%bool good_left~%bool good_right~%float32 near_m~%bool straight_lane~%float32 straight_lane_angle~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Lane3)))
  "Returns full string definition for message of type 'Lane3"
  (cl:format cl:nil "std_msgs/Header header~%~%float32 lane_center_offset~%float32 stopline_dist~%float32 stopline_angle~%float32[] lane_waypoints~%float32[] left_waypoints~%float32[] right_waypoints~%bool good_left~%bool good_right~%float32 near_m~%bool straight_lane~%float32 straight_lane_angle~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Lane3>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lane_waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'left_waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'right_waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
     1
     4
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Lane3>))
  "Converts a ROS message object to a list"
  (cl:list 'Lane3
    (cl:cons ':header (header msg))
    (cl:cons ':lane_center_offset (lane_center_offset msg))
    (cl:cons ':stopline_dist (stopline_dist msg))
    (cl:cons ':stopline_angle (stopline_angle msg))
    (cl:cons ':lane_waypoints (lane_waypoints msg))
    (cl:cons ':left_waypoints (left_waypoints msg))
    (cl:cons ':right_waypoints (right_waypoints msg))
    (cl:cons ':good_left (good_left msg))
    (cl:cons ':good_right (good_right msg))
    (cl:cons ':near_m (near_m msg))
    (cl:cons ':straight_lane (straight_lane msg))
    (cl:cons ':straight_lane_angle (straight_lane_angle msg))
))
