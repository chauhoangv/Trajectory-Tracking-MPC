; Auto-generated. Do not edit!


(cl:in-package utils-srv)


;//! \htmlinclude go_to_multiple-request.msg.html

(cl:defclass <go_to_multiple-request> (roslisp-msg-protocol:ros-message)
  ((vrefName
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
    :initform 0.0)
   (destinations
    :reader destinations
    :initarg :destinations
    :type (cl:vector utils-msg:Point2D)
   :initform (cl:make-array 0 :element-type 'utils-msg:Point2D :initial-element (cl:make-instance 'utils-msg:Point2D))))
)

(cl:defclass go_to_multiple-request (<go_to_multiple-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <go_to_multiple-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'go_to_multiple-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<go_to_multiple-request> is deprecated: use utils-srv:go_to_multiple-request instead.")))

(cl:ensure-generic-function 'vrefName-val :lambda-list '(m))
(cl:defmethod vrefName-val ((m <go_to_multiple-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:vrefName-val is deprecated.  Use utils-srv:vrefName instead.")
  (vrefName m))

(cl:ensure-generic-function 'x0-val :lambda-list '(m))
(cl:defmethod x0-val ((m <go_to_multiple-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:x0-val is deprecated.  Use utils-srv:x0 instead.")
  (x0 m))

(cl:ensure-generic-function 'y0-val :lambda-list '(m))
(cl:defmethod y0-val ((m <go_to_multiple-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:y0-val is deprecated.  Use utils-srv:y0 instead.")
  (y0 m))

(cl:ensure-generic-function 'yaw0-val :lambda-list '(m))
(cl:defmethod yaw0-val ((m <go_to_multiple-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:yaw0-val is deprecated.  Use utils-srv:yaw0 instead.")
  (yaw0 m))

(cl:ensure-generic-function 'destinations-val :lambda-list '(m))
(cl:defmethod destinations-val ((m <go_to_multiple-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:destinations-val is deprecated.  Use utils-srv:destinations instead.")
  (destinations m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <go_to_multiple-request>) ostream)
  "Serializes a message object of type '<go_to_multiple-request>"
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
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'destinations))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'destinations))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <go_to_multiple-request>) istream)
  "Deserializes a message object of type '<go_to_multiple-request>"
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
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'destinations) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'destinations)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'utils-msg:Point2D))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<go_to_multiple-request>)))
  "Returns string type for a service object of type '<go_to_multiple-request>"
  "utils/go_to_multipleRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'go_to_multiple-request)))
  "Returns string type for a service object of type 'go_to_multiple-request"
  "utils/go_to_multipleRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<go_to_multiple-request>)))
  "Returns md5sum for a message object of type '<go_to_multiple-request>"
  "3e9590ffda7f3c098d288272e4eaaa2d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'go_to_multiple-request)))
  "Returns md5sum for a message object of type 'go_to_multiple-request"
  "3e9590ffda7f3c098d288272e4eaaa2d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<go_to_multiple-request>)))
  "Returns full string definition for message of type '<go_to_multiple-request>"
  (cl:format cl:nil "# Request~%string vrefName~%float64 x0~%float64 y0~%float64 yaw0~%Point2D[] destinations~%~%================================================================================~%MSG: utils/Point2D~%float32 x~%float32 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'go_to_multiple-request)))
  "Returns full string definition for message of type 'go_to_multiple-request"
  (cl:format cl:nil "# Request~%string vrefName~%float64 x0~%float64 y0~%float64 yaw0~%Point2D[] destinations~%~%================================================================================~%MSG: utils/Point2D~%float32 x~%float32 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <go_to_multiple-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'vrefName))
     8
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'destinations) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <go_to_multiple-request>))
  "Converts a ROS message object to a list"
  (cl:list 'go_to_multiple-request
    (cl:cons ':vrefName (vrefName msg))
    (cl:cons ':x0 (x0 msg))
    (cl:cons ':y0 (y0 msg))
    (cl:cons ':yaw0 (yaw0 msg))
    (cl:cons ':destinations (destinations msg))
))
;//! \htmlinclude go_to_multiple-response.msg.html

(cl:defclass <go_to_multiple-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass go_to_multiple-response (<go_to_multiple-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <go_to_multiple-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'go_to_multiple-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<go_to_multiple-response> is deprecated: use utils-srv:go_to_multiple-response instead.")))

(cl:ensure-generic-function 'state_refs-val :lambda-list '(m))
(cl:defmethod state_refs-val ((m <go_to_multiple-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:state_refs-val is deprecated.  Use utils-srv:state_refs instead.")
  (state_refs m))

(cl:ensure-generic-function 'input_refs-val :lambda-list '(m))
(cl:defmethod input_refs-val ((m <go_to_multiple-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:input_refs-val is deprecated.  Use utils-srv:input_refs instead.")
  (input_refs m))

(cl:ensure-generic-function 'wp_attributes-val :lambda-list '(m))
(cl:defmethod wp_attributes-val ((m <go_to_multiple-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:wp_attributes-val is deprecated.  Use utils-srv:wp_attributes instead.")
  (wp_attributes m))

(cl:ensure-generic-function 'wp_normals-val :lambda-list '(m))
(cl:defmethod wp_normals-val ((m <go_to_multiple-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:wp_normals-val is deprecated.  Use utils-srv:wp_normals instead.")
  (wp_normals m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <go_to_multiple-response>) ostream)
  "Serializes a message object of type '<go_to_multiple-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'state_refs) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'input_refs) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wp_attributes) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wp_normals) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <go_to_multiple-response>) istream)
  "Deserializes a message object of type '<go_to_multiple-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'state_refs) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'input_refs) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wp_attributes) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wp_normals) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<go_to_multiple-response>)))
  "Returns string type for a service object of type '<go_to_multiple-response>"
  "utils/go_to_multipleResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'go_to_multiple-response)))
  "Returns string type for a service object of type 'go_to_multiple-response"
  "utils/go_to_multipleResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<go_to_multiple-response>)))
  "Returns md5sum for a message object of type '<go_to_multiple-response>"
  "3e9590ffda7f3c098d288272e4eaaa2d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'go_to_multiple-response)))
  "Returns md5sum for a message object of type 'go_to_multiple-response"
  "3e9590ffda7f3c098d288272e4eaaa2d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<go_to_multiple-response>)))
  "Returns full string definition for message of type '<go_to_multiple-response>"
  (cl:format cl:nil "# Response~%std_msgs/Float32MultiArray state_refs~%std_msgs/Float32MultiArray input_refs~%std_msgs/Float32MultiArray wp_attributes~%std_msgs/Float32MultiArray wp_normals~%~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'go_to_multiple-response)))
  "Returns full string definition for message of type 'go_to_multiple-response"
  (cl:format cl:nil "# Response~%std_msgs/Float32MultiArray state_refs~%std_msgs/Float32MultiArray input_refs~%std_msgs/Float32MultiArray wp_attributes~%std_msgs/Float32MultiArray wp_normals~%~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <go_to_multiple-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'state_refs))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'input_refs))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wp_attributes))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wp_normals))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <go_to_multiple-response>))
  "Converts a ROS message object to a list"
  (cl:list 'go_to_multiple-response
    (cl:cons ':state_refs (state_refs msg))
    (cl:cons ':input_refs (input_refs msg))
    (cl:cons ':wp_attributes (wp_attributes msg))
    (cl:cons ':wp_normals (wp_normals msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'go_to_multiple)))
  'go_to_multiple-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'go_to_multiple)))
  'go_to_multiple-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'go_to_multiple)))
  "Returns string type for a service object of type '<go_to_multiple>"
  "utils/go_to_multiple")