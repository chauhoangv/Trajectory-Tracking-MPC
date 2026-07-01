; Auto-generated. Do not edit!


(cl:in-package utils-srv)


;//! \htmlinclude goto_command-request.msg.html

(cl:defclass <goto_command-request> (roslisp-msg-protocol:ros-message)
  ((dest_x
    :reader dest_x
    :initarg :dest_x
    :type cl:float
    :initform 0.0)
   (dest_y
    :reader dest_y
    :initarg :dest_y
    :type cl:float
    :initform 0.0))
)

(cl:defclass goto_command-request (<goto_command-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goto_command-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goto_command-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<goto_command-request> is deprecated: use utils-srv:goto_command-request instead.")))

(cl:ensure-generic-function 'dest_x-val :lambda-list '(m))
(cl:defmethod dest_x-val ((m <goto_command-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:dest_x-val is deprecated.  Use utils-srv:dest_x instead.")
  (dest_x m))

(cl:ensure-generic-function 'dest_y-val :lambda-list '(m))
(cl:defmethod dest_y-val ((m <goto_command-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:dest_y-val is deprecated.  Use utils-srv:dest_y instead.")
  (dest_y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goto_command-request>) ostream)
  "Serializes a message object of type '<goto_command-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'dest_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'dest_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goto_command-request>) istream)
  "Deserializes a message object of type '<goto_command-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dest_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dest_y) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goto_command-request>)))
  "Returns string type for a service object of type '<goto_command-request>"
  "utils/goto_commandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goto_command-request)))
  "Returns string type for a service object of type 'goto_command-request"
  "utils/goto_commandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goto_command-request>)))
  "Returns md5sum for a message object of type '<goto_command-request>"
  "9b99b56ad3b4e93a7deab6c9c680fa9c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goto_command-request)))
  "Returns md5sum for a message object of type 'goto_command-request"
  "9b99b56ad3b4e93a7deab6c9c680fa9c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goto_command-request>)))
  "Returns full string definition for message of type '<goto_command-request>"
  (cl:format cl:nil "# Request~%float64 dest_x~%float64 dest_y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goto_command-request)))
  "Returns full string definition for message of type 'goto_command-request"
  (cl:format cl:nil "# Request~%float64 dest_x~%float64 dest_y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goto_command-request>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goto_command-request>))
  "Converts a ROS message object to a list"
  (cl:list 'goto_command-request
    (cl:cons ':dest_x (dest_x msg))
    (cl:cons ':dest_y (dest_y msg))
))
;//! \htmlinclude goto_command-response.msg.html

(cl:defclass <goto_command-response> (roslisp-msg-protocol:ros-message)
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
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray))
   (success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass goto_command-response (<goto_command-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goto_command-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goto_command-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<goto_command-response> is deprecated: use utils-srv:goto_command-response instead.")))

(cl:ensure-generic-function 'state_refs-val :lambda-list '(m))
(cl:defmethod state_refs-val ((m <goto_command-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:state_refs-val is deprecated.  Use utils-srv:state_refs instead.")
  (state_refs m))

(cl:ensure-generic-function 'input_refs-val :lambda-list '(m))
(cl:defmethod input_refs-val ((m <goto_command-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:input_refs-val is deprecated.  Use utils-srv:input_refs instead.")
  (input_refs m))

(cl:ensure-generic-function 'wp_attributes-val :lambda-list '(m))
(cl:defmethod wp_attributes-val ((m <goto_command-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:wp_attributes-val is deprecated.  Use utils-srv:wp_attributes instead.")
  (wp_attributes m))

(cl:ensure-generic-function 'wp_normals-val :lambda-list '(m))
(cl:defmethod wp_normals-val ((m <goto_command-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:wp_normals-val is deprecated.  Use utils-srv:wp_normals instead.")
  (wp_normals m))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <goto_command-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:success-val is deprecated.  Use utils-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goto_command-response>) ostream)
  "Serializes a message object of type '<goto_command-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'state_refs) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'input_refs) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wp_attributes) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wp_normals) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goto_command-response>) istream)
  "Deserializes a message object of type '<goto_command-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'state_refs) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'input_refs) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wp_attributes) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wp_normals) istream)
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goto_command-response>)))
  "Returns string type for a service object of type '<goto_command-response>"
  "utils/goto_commandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goto_command-response)))
  "Returns string type for a service object of type 'goto_command-response"
  "utils/goto_commandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goto_command-response>)))
  "Returns md5sum for a message object of type '<goto_command-response>"
  "9b99b56ad3b4e93a7deab6c9c680fa9c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goto_command-response)))
  "Returns md5sum for a message object of type 'goto_command-response"
  "9b99b56ad3b4e93a7deab6c9c680fa9c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goto_command-response>)))
  "Returns full string definition for message of type '<goto_command-response>"
  (cl:format cl:nil "# Response~%std_msgs/Float32MultiArray state_refs~%std_msgs/Float32MultiArray input_refs~%std_msgs/Float32MultiArray wp_attributes~%std_msgs/Float32MultiArray wp_normals~%bool success~%~%~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goto_command-response)))
  "Returns full string definition for message of type 'goto_command-response"
  (cl:format cl:nil "# Response~%std_msgs/Float32MultiArray state_refs~%std_msgs/Float32MultiArray input_refs~%std_msgs/Float32MultiArray wp_attributes~%std_msgs/Float32MultiArray wp_normals~%bool success~%~%~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goto_command-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'state_refs))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'input_refs))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wp_attributes))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wp_normals))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goto_command-response>))
  "Converts a ROS message object to a list"
  (cl:list 'goto_command-response
    (cl:cons ':state_refs (state_refs msg))
    (cl:cons ':input_refs (input_refs msg))
    (cl:cons ':wp_attributes (wp_attributes msg))
    (cl:cons ':wp_normals (wp_normals msg))
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'goto_command)))
  'goto_command-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'goto_command)))
  'goto_command-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goto_command)))
  "Returns string type for a service object of type '<goto_command>"
  "utils/goto_command")