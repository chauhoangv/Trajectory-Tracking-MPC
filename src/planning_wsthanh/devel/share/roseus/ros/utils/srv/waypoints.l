;; Auto-generated. Do not edit!


(when (boundp 'utils::waypoints)
  (if (not (find-package "UTILS"))
    (make-package "UTILS"))
  (shadow 'waypoints (find-package "UTILS")))
(unless (find-package "UTILS::WAYPOINTS")
  (make-package "UTILS::WAYPOINTS"))
(unless (find-package "UTILS::WAYPOINTSREQUEST")
  (make-package "UTILS::WAYPOINTSREQUEST"))
(unless (find-package "UTILS::WAYPOINTSRESPONSE")
  (make-package "UTILS::WAYPOINTSRESPONSE"))

(in-package "ROS")



(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass utils::waypointsRequest
  :super ros::object
  :slots (_pathName _vrefName _x0 _y0 _yaw0 ))

(defmethod utils::waypointsRequest
  (:init
   (&key
    ((:pathName __pathName) "")
    ((:vrefName __vrefName) "")
    ((:x0 __x0) 0.0)
    ((:y0 __y0) 0.0)
    ((:yaw0 __yaw0) 0.0)
    )
   (send-super :init)
   (setq _pathName (string __pathName))
   (setq _vrefName (string __vrefName))
   (setq _x0 (float __x0))
   (setq _y0 (float __y0))
   (setq _yaw0 (float __yaw0))
   self)
  (:pathName
   (&optional __pathName)
   (if __pathName (setq _pathName __pathName)) _pathName)
  (:vrefName
   (&optional __vrefName)
   (if __vrefName (setq _vrefName __vrefName)) _vrefName)
  (:x0
   (&optional __x0)
   (if __x0 (setq _x0 __x0)) _x0)
  (:y0
   (&optional __y0)
   (if __y0 (setq _y0 __y0)) _y0)
  (:yaw0
   (&optional __yaw0)
   (if __yaw0 (setq _yaw0 __yaw0)) _yaw0)
  (:serialization-length
   ()
   (+
    ;; string _pathName
    4 (length _pathName)
    ;; string _vrefName
    4 (length _vrefName)
    ;; float64 _x0
    8
    ;; float64 _y0
    8
    ;; float64 _yaw0
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _pathName
       (write-long (length _pathName) s) (princ _pathName s)
     ;; string _vrefName
       (write-long (length _vrefName) s) (princ _vrefName s)
     ;; float64 _x0
       (sys::poke _x0 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y0
       (sys::poke _y0 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw0
       (sys::poke _yaw0 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _pathName
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _pathName (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _vrefName
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _vrefName (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _x0
     (setq _x0 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y0
     (setq _y0 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw0
     (setq _yaw0 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass utils::waypointsResponse
  :super ros::object
  :slots (_state_refs _input_refs _wp_attributes _wp_normals ))

(defmethod utils::waypointsResponse
  (:init
   (&key
    ((:state_refs __state_refs) (instance std_msgs::Float32MultiArray :init))
    ((:input_refs __input_refs) (instance std_msgs::Float32MultiArray :init))
    ((:wp_attributes __wp_attributes) (instance std_msgs::Float32MultiArray :init))
    ((:wp_normals __wp_normals) (instance std_msgs::Float32MultiArray :init))
    )
   (send-super :init)
   (setq _state_refs __state_refs)
   (setq _input_refs __input_refs)
   (setq _wp_attributes __wp_attributes)
   (setq _wp_normals __wp_normals)
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
   ;;
   self)
  )

(defclass utils::waypoints
  :super ros::object
  :slots ())

(setf (get utils::waypoints :md5sum-) "4b7f567167e5a0533521ec8c8360b4ea")
(setf (get utils::waypoints :datatype-) "utils/waypoints")
(setf (get utils::waypoints :request) utils::waypointsRequest)
(setf (get utils::waypoints :response) utils::waypointsResponse)

(defmethod utils::waypointsRequest
  (:response () (instance utils::waypointsResponse :init)))

(setf (get utils::waypointsRequest :md5sum-) "4b7f567167e5a0533521ec8c8360b4ea")
(setf (get utils::waypointsRequest :datatype-) "utils/waypointsRequest")
(setf (get utils::waypointsRequest :definition-)
      "# Request
string pathName
string vrefName
float64 x0
float64 y0
float64 yaw0
---
# Response
std_msgs/Float32MultiArray state_refs
std_msgs/Float32MultiArray input_refs
std_msgs/Float32MultiArray wp_attributes
std_msgs/Float32MultiArray wp_normals


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

(setf (get utils::waypointsResponse :md5sum-) "4b7f567167e5a0533521ec8c8360b4ea")
(setf (get utils::waypointsResponse :datatype-) "utils/waypointsResponse")
(setf (get utils::waypointsResponse :definition-)
      "# Request
string pathName
string vrefName
float64 x0
float64 y0
float64 yaw0
---
# Response
std_msgs/Float32MultiArray state_refs
std_msgs/Float32MultiArray input_refs
std_msgs/Float32MultiArray wp_attributes
std_msgs/Float32MultiArray wp_normals


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



(provide :utils/waypoints "4b7f567167e5a0533521ec8c8360b4ea")


