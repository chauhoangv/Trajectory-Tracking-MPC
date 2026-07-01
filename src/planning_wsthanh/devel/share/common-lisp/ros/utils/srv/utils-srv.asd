
(cl:in-package :asdf)

(defsystem "utils-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
               :utils-msg
)
  :components ((:file "_package")
    (:file "go_to" :depends-on ("_package_go_to"))
    (:file "_package_go_to" :depends-on ("_package"))
    (:file "go_to_multiple" :depends-on ("_package_go_to_multiple"))
    (:file "_package_go_to_multiple" :depends-on ("_package"))
    (:file "goto_command" :depends-on ("_package_goto_command"))
    (:file "_package_goto_command" :depends-on ("_package"))
    (:file "set_states" :depends-on ("_package_set_states"))
    (:file "_package_set_states" :depends-on ("_package"))
    (:file "waypoints" :depends-on ("_package_waypoints"))
    (:file "_package_waypoints" :depends-on ("_package"))
  ))