(define (domain sandwich_example)

    (:requirements :strips :typing :conditional-effects :negative-preconditions :equality :universal-preconditions)

    (:types
        bread ham cheese table plate- object
        arm
    )

    (:predicates
        (is_empty ?arm)
        (on ?x ?y)
        (on-table ?x)
        (holding ?arm ?x)
        (top ?obj - object)
    )
    
    (:action pickup
        :parameters (?obj - object ?arm - arm)
        :precondition (and 
                        (on-table ?obj)
                        (not (holding ?arm ?obj))
                        (is_empty ?arm)
        )
        :effect (and
                    (not (is_empty ?arm))
                    (not (on-table ?obj))
                    (holding ?arm ?obj)
        )
    )

    (:action putdown
        :parameters (?obj - object ?arm - arm)
        :precondition (and 
                        (not (on-table ?obj))
                        (holding ?arm ?obj)
                        (not (is_empty ?arm))
        )
        :effect (and
                    (is_empty ?arm)
                    (on-table ?obj)
                    (not (holding ?arm ?obj))
        )
    )
    
    (:action stack
        :parameters (?obj1 - object ?obj2 - object ?arm - arm ?stk - stack)
        :precondition (and 
                        (holding ?arm ?obj1)
                        (top ?obj2)
                        (not (holding ?arm ?obj2))
                        (not (on ?obj2 ?obj1))
        )
        :effect (and
                    (not (holding ?arm ?obj1))
                    (on ?obj1 ?obj2)
        )
    )
    
    (:action unstack
        :parameters (?obj1 - object
                     obj2 - object)
        :precondition (and
            
         )
        :effect (and )
    )
    
)