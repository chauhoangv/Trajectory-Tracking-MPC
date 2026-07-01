; Auto-generated. Do not edit!


(cl:in-package utils-srv)


;//! \htmlinclude set_states-request.msg.html

(cl:defclass <set_states-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0))
)

(cl:defclass set_states-request (<set_states-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <set_states-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'set_states-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<set_states-request> is deprecated: use utils-srv:set_states-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <set_states-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:x-val is deprecated.  Use utils-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <set_states-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:y-val is deprecated.  Use utils-srv:y instead.")
  (y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <set_states-request>) ostream)
  "Serializes a message object of type '<set_states-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <set_states-request>) istream)
  "Deserializes a message object of type '<set_states-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<set_states-request>)))
  "Returns string type for a service object of type '<set_states-request>"
  "utils/set_statesRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'set_states-request)))
  "Returns string type for a service object of type 'set_states-request"
  "utils/set_statesRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<set_states-request>)))
  "Returns md5sum for a message object of type '<set_states-request>"
  "5e71a6351e81d13c69a7ec3796769e8e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'set_states-request)))
  "Returns md5sum for a message object of type 'set_states-request"
  "5e71a6351e81d13c69a7ec3796769e8e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<set_states-request>)))
  "Returns full string definition for message of type '<set_states-request>"
  (cl:format cl:nil "# Request~%float64 x~%float64 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'set_states-request)))
  "Returns full string definition for message of type 'set_states-request"
  (cl:format cl:nil "# Request~%float64 x~%float64 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <set_states-request>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <set_states-request>))
  "Converts a ROS message object to a list"
  (cl:list 'set_states-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
))
;//! \htmlinclude set_states-response.msg.html

(cl:defclass <set_states-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass set_states-response (<set_states-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <set_states-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'set_states-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name utils-srv:<set_states-response> is deprecated: use utils-srv:set_states-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <set_states-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader utils-srv:success-val is deprecated.  Use utils-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <set_states-response>) ostream)
  "Serializes a message object of type '<set_states-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <set_states-response>) istream)
  "Deserializes a message object of type '<set_states-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<set_states-response>)))
  "Returns string type for a service object of type '<set_states-response>"
  "utils/set_statesResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'set_states-response)))
  "Returns string type for a service object of type 'set_states-response"
  "utils/set_statesResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<set_states-response>)))
  "Returns md5sum for a message object of type '<set_states-response>"
  "5e71a6351e81d13c69a7ec3796769e8e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'set_states-response)))
  "Returns md5sum for a message object of type 'set_states-response"
  "5e71a6351e81d13c69a7ec3796769e8e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<set_states-response>)))
  "Returns full string definition for message of type '<set_states-response>"
  (cl:format cl:nil "# Response~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'set_states-response)))
  "Returns full string definition for message of type 'set_states-response"
  (cl:format cl:nil "# Response~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <set_states-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <set_states-response>))
  "Converts a ROS message object to a list"
  (cl:list 'set_states-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'set_states)))
  'set_states-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'set_states)))
  'set_states-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'set_states)))
  "Returns string type for a service object of type '<set_states>"
  "utils/set_states")