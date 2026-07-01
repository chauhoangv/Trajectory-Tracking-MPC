;; Auto-generated. Do not edit!


(when (boundp 'utils::go_to_multiple)
  (if (not (find-package "UTILS"))
    (make-package "UTILS"))
  (shadow 'go_to_multiple (find-package "UTILS")))
(unless (find-package "UTILS::GO_TO_MULTIPLE")
  (make-package "UTILS::GO_TO_MULTIPLE"))
(unless (find-package "UTILS::GO_TO_MULTIPLEREQUEST")
  (make-package "UTILS::GO_TO_MULTIPLEREQUEST"))
(unless (find-package "UTILS::GO_TO_MULTIPLERESPONSE")
  (make-package "UTILS::GO_TO_MULTIPLERESPONSE"))

(in-package "ROS")



(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass utils::go_to_multipleRequest
  :super ros::object
  :slots (_vrefName _x0 _y0 _yaw0 _destinations ))

(defmethod utils::go_to_multipleRequest
  (:init
   (&key
    ((:vrefName __vrefName) "")
    ((:x0 __x0) 0.0)
    ((:y0 __y0) 0.0)
    ((:yaw0 __yaw0) 0.0)
    ((:destinations __destinations) ())
    )
   (send-super :init)
   (setq _vrefName (string __vrefName))
   (setq _x0 (float __x0))
   (setq _y0 (float __y0))
   (setq _yaw0 (float __yaw0))
   (setq _destinations __destinations)
   self)
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
  (:destinations
   (&rest __destinations)
   (if (keywordp (car __destinations))
       (send* _destinations __destinations)
     (progn
       (if __destinations (setq _destinations (car __destinations)))
       _destinations)))
  (:serialization-length
   ()
   (+
    ;; string _vrefName
    4 (length _vrefName)
    ;; float64 _x0
    8
    ;; float64 _y0
    8
    ;; float64 _yaw0
    8
    ;; utils/Point2D[] _destinations
    (apply #'+ (send-all _destinations :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _vrefName
       (write-long (length _vrefName) s) (princ _vrefName s)
     ;; float64 _x0
       (sys::poke _x0 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y0
       (sys::poke _y0 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw0
       (sys::poke _yaw0 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; utils/Point2D[] _destinations
     (write-long (length _destinations) s)
     (dolist (elem _destinations)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _vrefName
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _vrefName (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _x0
     (setq _x0 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y0
     (setq _y0 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw0
     (setq _yaw0 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; utils/Point2D[] _destinations
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _destinations (let (r) (dotimes (i n) (push (instance utils::Point2D :init) r)) r))
     (dolist (elem- _destinations)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass utils::go_to_multipleResponse
  :super ros::object
  :slots (_state_refs _input_refs _wp_attributes _wp_normals ))

(defmethod utils::go_to_multipleResponse
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

(defclass utils::go_to_multiple
  :super ros::object
  :slots ())

(setf (get utils::go_to_multiple :md5sum-) "3e9590ffda7f3c098d288272e4eaaa2d")
(setf (get utils::go_to_multiple :datatype-) "utils/go_to_multiple")
(setf (get utils::go_to_multiple :request) utils::go_to_multipleRequest)
(setf (get utils::go_to_multiple :response) utils::go_to_multipleResponse)

(defmethod utils::go_to_multipleRequest
  (:response () (instance utils::go_to_multipleResponse :init)))

(setf (get utils::go_to_multipleRequest :md5sum-) "3e9590ffda7f3c098d288272e4eaaa2d")
(setf (get utils::go_to_multipleRequest :datatype-) "utils/go_to_multipleRequest")
(setf (get utils::go_to_multipleRequest :definition-)
      "# Request
string vrefName
float64 x0
float64 y0
float64 yaw0
Point2D[] destinations

================================================================================
MSG: utils/Point2D
float32 x
float32 y
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

(setf (get utils::go_to_multipleResponse :md5sum-) "3e9590ffda7f3c098d288272e4eaaa2d")
(setf (get utils::go_to_multipleResponse :datatype-) "utils/go_to_multipleResponse")
(setf (get utils::go_to_multipleResponse :definition-)
      "# Request
string vrefName
float64 x0
float64 y0
float64 yaw0
Point2D[] destinations

================================================================================
MSG: utils/Point2D
float32 x
float32 y
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



(provide :utils/go_to_multiple "3e9590ffda7f3c098d288272e4eaaa2d")


