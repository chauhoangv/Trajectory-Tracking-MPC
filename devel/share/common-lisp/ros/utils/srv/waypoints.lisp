; Auto-generated. Do not edit!


(cl:in-package utils-srv)


;//! \htmlinclude waypoints-request.msg.html

(cl:defclass <waypoints-request> (roslisp-msg-protocol:ros-message)
  ((pathName
    :reader pathName
    :initarg :pathName
    :type cl:string
    :initform "")
   (vrefName
    :reader vrefName
    :initarg :vrefName
    :type cl:string
    :initform "")
   (x0
    :reader x0
    :initarg :x0
    :type cl:float
    :initform 0.0)
   (y0
    :reader y0
    :initarg :y0
    :type cl:float
    :initform 0.0)
   (yaw0
    :reader yaw0
    :initarg :yaw0
    :type cl:float
    :initform 0.0))
)

(cl:defclass waypoints-request (<waypoints-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <waypoints-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'waypoints-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<waypoints-request> is deprecated: use utils-srv:waypoints-request instead.")))

(cl:ensure-generic-function 'pathName-val :lambda-list '(m))
(cl:defmethod pathName-val ((m <waypoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:pathName-val is deprecated.  Use utils-srv:pathName instead.")
  (pathName m))

(cl:ensure-generic-function 'vrefName-val :lambda-list '(m))
(cl:defmethod vrefName-val ((m <waypoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:vrefName-val is deprecated.  Use utils-srv:vrefName instead.")
  (vrefName m))

(cl:ensure-generic-function 'x0-val :lambda-list '(m))
(cl:defmethod x0-val ((m <waypoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:x0-val is deprecated.  Use utils-srv:x0 instead.")
  (x0 m))

(cl:ensure-generic-function 'y0-val :lambda-list '(m))
(cl:defmethod y0-val ((m <waypoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:y0-val is deprecated.  Use utils-srv:y0 instead.")
  (y0 m))

(cl:ensure-generic-function 'yaw0-val :lambda-list '(m))
(cl:defmethod yaw0-val ((m <waypoints-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:yaw0-val is deprecated.  Use utils-srv:yaw0 instead.")
  (yaw0 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <waypoints-request>) ostream)
  "Serializes a message object of type '<waypoints-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'pathName))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'pathName))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'vrefName))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'vrefName))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'yaw0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <waypoints-request>) istream)
  "Deserializes a message object of type '<waypoints-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pathName) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'pathName) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'vrefName) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'vrefName) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x0) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y0) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw0) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<waypoints-request>)))
  "Returns string type for a service object of type '<waypoints-request>"
  "utils/waypointsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'waypoints-request)))
  "Returns string type for a service object of type 'waypoints-request"
  "utils/waypointsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<waypoints-request>)))
  "Returns md5sum for a message object of type '<waypoints-request>"
  "4b7f567167e5a0533521ec8c8360b4ea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'waypoints-request)))
  "Returns md5sum for a message object of type 'waypoints-request"
  "4b7f567167e5a0533521ec8c8360b4ea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<waypoints-request>)))
  "Returns full string definition for message of type '<waypoints-request>"
  (cl:format cl:nil "# Request~%string pathName~%string vrefName~%float64 x0~%float64 y0~%float64 yaw0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'waypoints-request)))
  "Returns full string definition for message of type 'waypoints-request"
  (cl:format cl:nil "# Request~%string pathName~%string vrefName~%float64 x0~%float64 y0~%float64 yaw0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <waypoints-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'pathName))
     4 (cl:length (cl:slot-value msg 'vrefName))
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <waypoints-request>))
  "Converts a ROS message object to a list"
  (cl:list 'waypoints-request
    (cl:cons ':pathName (pathName msg))
    (cl:cons ':vrefName (vrefName msg))
    (cl:cons ':x0 (x0 msg))
    (cl:cons ':y0 (y0 msg))
    (cl:cons ':yaw0 (yaw0 msg))
))
;//! \htmlinclude waypoints-response.msg.html

(cl:defclass <waypoints-response> (roslisp-msg-protocol:ros-message)
  ((state_refs
    :reader state_refs
    :initarg :state_refs
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray))
   (input_refs
    :reader input_refs
    :initarg :input_refs
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray))
   (wp_attributes
    :reader wp_attributes
    :initarg :wp_attributes
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray))
   (wp_normals
    :reader wp_normals
    :initarg :wp_normals
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray)))
)

(cl:defclass waypoints-response (<waypoints-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <waypoints-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'waypoints-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<waypoints-response> is deprecated: use utils-srv:waypoints-response instead.")))

(cl:ensure-generic-function 'state_refs-val :lambda-list '(m))
(cl:defmethod state_refs-val ((m <waypoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:state_refs-val is deprecated.  Use utils-srv:state_refs instead.")
  (state_refs m))

(cl:ensure-generic-function 'input_refs-val :lambda-list '(m))
(cl:defmethod input_refs-val ((m <waypoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:input_refs-val is deprecated.  Use utils-srv:input_refs instead.")
  (input_refs m))

(cl:ensure-generic-function 'wp_attributes-val :lambda-list '(m))
(cl:defmethod wp_attributes-val ((m <waypoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:wp_attributes-val is deprecated.  Use utils-srv:wp_attributes instead.")
  (wp_attributes m))

(cl:ensure-generic-function 'wp_normals-val :lambda-list '(m))
(cl:defmethod wp_normals-val ((m <waypoints-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:wp_normals-val is deprecated.  Use utils-srv:wp_normals instead.")
  (wp_normals m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <waypoints-response>) ostream)
  "Serializes a message object of type '<waypoints-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'state_refs) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'input_refs) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wp_attributes) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wp_normals) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <waypoints-response>) istream)
  "Deserializes a message object of type '<waypoints-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'state_refs) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'input_refs) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wp_attributes) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wp_normals) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<waypoints-response>)))
  "Returns string type for a service object of type '<waypoints-response>"
  "utils/waypointsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'waypoints-response)))
  "Returns string type for a service object of type 'waypoints-response"
  "utils/waypointsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<waypoints-response>)))
  "Returns md5sum for a message object of type '<waypoints-response>"
  "4b7f567167e5a0533521ec8c8360b4ea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'waypoints-response)))
  "Returns md5sum for a message object of type 'waypoints-response"
  "4b7f567167e5a0533521ec8c8360b4ea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<waypoints-response>)))
  "Returns full string definition for message of type '<waypoints-response>"
  (cl:format cl:nil "# Response~%std_msgs/Float32MultiArray state_refs~%std_msgs/Float32MultiArray input_refs~%std_msgs/Float32MultiArray wp_attributes~%std_msgs/Float32MultiArray wp_normals~%~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'waypoints-response)))
  "Returns full string definition for message of type 'waypoints-response"
  (cl:format cl:nil "# Response~%std_msgs/Float32MultiArray state_refs~%std_msgs/Float32MultiArray input_refs~%std_msgs/Float32MultiArray wp_attributes~%std_msgs/Float32MultiArray wp_normals~%~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <waypoints-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'state_refs))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'input_refs))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wp_attributes))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wp_normals))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <waypoints-response>))
  "Converts a ROS message object to a list"
  (cl:list 'waypoints-response
    (cl:cons ':state_refs (state_refs msg))
    (cl:cons ':input_refs (input_refs msg))
    (cl:cons ':wp_attributes (wp_attributes msg))
    (cl:cons ':wp_normals (wp_normals msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'waypoints)))
  'waypoints-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'waypoints)))
  'waypoints-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'waypoints)))
  "Returns string type for a service object of type '<waypoints>"
  "utils/waypoints")