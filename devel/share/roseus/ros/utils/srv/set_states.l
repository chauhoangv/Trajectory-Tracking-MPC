;; Auto-generated. Do not edit!


(when (boundp 'utils::set_states)
  (if (not (find-package "UTILS"))
    (make-package "UTILS"))
  (shadow 'set_states (find-package "UTILS")))
(unless (find-package "UTILS::SET_STATES")
  (make-package "UTILS::SET_STATES"))
(unless (find-package "UTILS::SET_STATESREQUEST")
  (make-package "UTILS::SET_STATESREQUEST"))
(unless (find-package "UTILS::SET_STATESRESPONSE")
  (make-package "UTILS::SET_STATESRESPONSE"))

(in-package "ROS")





(defclass utils::set_statesRequest
  :super ros::object
  :slots (_x _y ))

(defmethod utils::set_statesRequest
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:serialization-length
   ()
   (+
    ;; float64 _x
    8
    ;; float64 _y
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass utils::set_statesResponse
  :super ros::object
  :slots (_success ))

(defmethod utils::set_statesResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass utils::set_states
  :super ros::object
  :slots ())

(setf (get utils::set_states :md5sum-) "5e71a6351e81d13c69a7ec3796769e8e")
(setf (get utils::set_states :datatype-) "utils/set_states")
(setf (get utils::set_states :request) utils::set_statesRequest)
(setf (get utils::set_states :response) utils::set_statesResponse)

(defmethod utils::set_statesRequest
  (:response () (instance utils::set_statesResponse :init)))

(setf (get utils::set_statesRequest :md5sum-) "5e71a6351e81d13c69a7ec3796769e8e")
(setf (get utils::set_statesRequest :datatype-) "utils/set_statesRequest")
(setf (get utils::set_statesRequest :definition-)
      "# Request
float64 x
float64 y
---
# Response
bool success

")

(setf (get utils::set_statesResponse :md5sum-) "5e71a6351e81d13c69a7ec3796769e8e")
(setf (get utils::set_statesResponse :datatype-) "utils/set_statesResponse")
(setf (get utils::set_statesResponse :definition-)
      "# Request
float64 x
float64 y
---
# Response
bool success

")



(provide :utils/set_states "5e71a6351e81d13c69a7ec3796769e8e")


