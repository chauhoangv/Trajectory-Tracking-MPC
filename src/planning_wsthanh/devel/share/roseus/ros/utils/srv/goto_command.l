;; Auto-generated. Do not edit!


(when (boundp 'utils::goto_command)
  (if (not (find-package "UTILS"))
    (make-package "UTILS"))
  (shadow 'goto_command (find-package "UTILS")))
(unless (find-package "UTILS::GOTO_COMMAND")
  (make-package "UTILS::GOTO_COMMAND"))
(unless (find-package "UTILS::GOTO_COMMANDREQUEST")
  (make-package "UTILS::GOTO_COMMANDREQUEST"))
(unless (find-package "UTILS::GOTO_COMMANDRESPONSE")
  (make-package "UTILS::GOTO_COMMANDRESPONSE"))

(in-package "ROS")



(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass utils::goto_commandRequest
  :super ros::object
  :slots (_dest_x _dest_y ))

(defmethod utils::goto_commandRequest
  (:init
   (&key
    ((:dest_x __dest_x) 0.0)
    ((:dest_y __dest_y) 0.0)
    )
   (send-super :init)
   (setq _dest_x (float __dest_x))
   (setq _dest_y (float __dest_y))
   self)
  (:dest_x
   (&optional __dest_x)
   (if __dest_x (setq _dest_x __dest_x)) _dest_x)
  (:dest_y
   (&optional __dest_y)
   (if __dest_y (setq _dest_y __dest_y)) _dest_y)
  (:serialization-length
   ()
   (+
    ;; float64 _dest_x
    8
    ;; float64 _dest_y
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _dest_x
       (sys::poke _dest_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _dest_y
       (sys::poke _dest_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _dest_x
     (setq _dest_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _dest_y
     (setq _dest_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass utils::goto_commandResponse
  :super ros::object
  :slots (_state_refs _input_refs _wp_attributes _wp_normals _success ))

(defmethod utils::goto_commandResponse
  (:init
   (&key
    ((:state_refs __state_refs) (instance std_msgs::Float32MultiArray :init))
    ((:input_refs __input_refs) (instance std_msgs::Float32MultiArray :init))
    ((:wp_attributes __wp_attributes) (instance std_msgs::Float32MultiArray :init))
    ((:wp_normals __wp_normals) (instance std_msgs::Float32MultiArray :init))
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _state_refs __state_refs)
   (setq _input_refs __input_refs)
   (setq _wp_attributes __wp_attributes)
   (setq _wp_normals __wp_normals)
   (setq _success __success)
   self)
  (:state_refs
   (&rest __state_refs)
   (if (keywordp (car __state_refs))
       (send* _state_refs __state_refs)
     (progn
       (if __state_refs (setq _state_refs (car __state_refs)))
       _state_refs)))
  (:input_refs
   (&rest __input_refs)
   (if (keywordp (car __input_refs))
       (send* _input_refs __input_refs)
     (progn
       (if __input_refs (setq _input_refs (car __input_refs)))
       _input_refs)))
  (:wp_attributes
   (&rest __wp_attributes)
   (if (keywordp (car __wp_attributes))
       (send* _wp_attributes __wp_attributes)
     (progn
       (if __wp_attributes (setq _wp_attributes (car __wp_attributes)))
       _wp_attributes)))
  (:wp_normals
   (&rest __wp_normals)
   (if (keywordp (car __wp_normals))
       (send* _wp_normals __wp_normals)
     (progn
       (if __wp_normals (setq _wp_normals (car __wp_normals)))
       _wp_normals)))
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Float32MultiArray _state_refs
    (send _state_refs :serialization-length)
    ;; std_msgs/Float32MultiArray _input_refs
    (send _input_refs :serialization-length)
    ;; std_msgs/Float32MultiArray _wp_attributes
    (send _wp_attributes :serialization-length)
    ;; std_msgs/Float32MultiArray _wp_normals
    (send _wp_normals :serialization-length)
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Float32MultiArray _state_refs
       (send _state_refs :serialize s)
     ;; std_msgs/Float32MultiArray _input_refs
       (send _input_refs :serialize s)
     ;; std_msgs/Float32MultiArray _wp_attributes
       (send _wp_attributes :serialize s)
     ;; std_msgs/Float32MultiArray _wp_normals
       (send _wp_normals :serialize s)
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Float32MultiArray _state_refs
     (send _state_refs :deserialize buf ptr-) (incf ptr- (send _state_refs :serialization-length))
   ;; std_msgs/Float32MultiArray _input_refs
     (send _input_refs :deserialize buf ptr-) (incf ptr- (send _input_refs :serialization-length))
   ;; std_msgs/Float32MultiArray _wp_attributes
     (send _wp_attributes :deserialize buf ptr-) (incf ptr- (send _wp_attributes :serialization-length))
   ;; std_msgs/Float32MultiArray _wp_normals
     (send _wp_normals :deserialize buf ptr-) (incf ptr- (send _wp_normals :serialization-length))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass utils::goto_command
  :super ros::object
  :slots ())

(setf (get utils::goto_command :md5sum-) "9b99b56ad3b4e93a7deab6c9c680fa9c")
(setf (get utils::goto_command :datatype-) "utils/goto_command")
(setf (get utils::goto_command :request) utils::goto_commandRequest)
(setf (get utils::goto_command :response) utils::goto_commandResponse)

(defmethod utils::goto_commandRequest
  (:response () (instance utils::goto_commandResponse :init)))

(setf (get utils::goto_commandRequest :md5sum-) "9b99b56ad3b4e93a7deab6c9c680fa9c")
(setf (get utils::goto_commandRequest :datatype-) "utils/goto_commandRequest")
(setf (get utils::goto_commandRequest :definition-)
      "# Request
float64 dest_x
float64 dest_y
---
# Response
std_msgs/Float32MultiArray state_refs
std_msgs/Float32MultiArray input_refs
std_msgs/Float32MultiArray wp_attributes
std_msgs/Float32MultiArray wp_normals
bool success



================================================================================
MSG: std_msgs/Float32MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
float32[]         data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
")

(setf (get utils::goto_commandResponse :md5sum-) "9b99b56ad3b4e93a7deab6c9c680fa9c")
(setf (get utils::goto_commandResponse :datatype-) "utils/goto_commandResponse")
(setf (get utils::goto_commandResponse :definition-)
      "# Request
float64 dest_x
float64 dest_y
---
# Response
std_msgs/Float32MultiArray state_refs
std_msgs/Float32MultiArray input_refs
std_msgs/Float32MultiArray wp_attributes
std_msgs/Float32MultiArray wp_normals
bool success



================================================================================
MSG: std_msgs/Float32MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
float32[]         data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
")



(provide :utils/goto_command "9b99b56ad3b4e93a7deab6c9c680fa9c")


