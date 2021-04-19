(define (domain sandwich_example)
    (:requirements :strips :typing)
    (:types
        object
        bread ham cheese plate - object
    )

    (:predicates
        (top ?x)
        (holding ?x)
        (on ?x ?y)
        (on-table ?x)
        (not-holding)
    )
    
    (:action pickup
        :parameters (?x - object)
        :precondition (and 
            (on-table ?x)
            (not-holding)
        )
        :effect (and 
            (not (not-holding))
            (holding ?x)
        )
    )

    (:action putdown
        :parameters (?x - object)
        :precondition (and 
            (holding ?x)
        )
        :effect (and 
            (not (holding ?x))
            (not-holding)
            (on-table ?x)
        )
    )
    
    (:action stack
        :parameters (?x - object ?y - object)
        :precondition (and 
            (holding ?x)
            (top ?y)
        )
        :effect (and 
            (not (holding ?x))
            (not (top ?y))
            (top ?x)
            (on ?x ?y)
            (not-holding)
        )
    )
    
    (:action unstack
        :parameters (?x - object ?y - object)
        :precondition (and 
            (top ?x)
            (on ?x ?y)
            (not-holding)
        )
        :effect (and
            (not (top ?x))
            (top ?y)
            (not (on ?x ?y))
            (holding ?x)
        )
    )
)

