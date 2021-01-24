(define (domain dockyard)
    (:requirements :typing :durative-actions :negative-preconditions)
    (:types
        location
        bridge dock storage - location

        employee
        robot worker - employee

        transport
        truck - transport

        vehicle
        ship crane - vehicle

        cargo
    )
    (:predicates (is_in ?x ?y)
                 (path ?a ?b)
                 (available ?empl)
                 (driving ?empl ?trn))
    
    (:durative-action walk
        :parameters (?empl - employee ?from - location ?to - location ?trn - transport)
        :duration (= ?duration 15)
        :condition (and (at start (is_in ?empl ?from))
                        (at start (path ?from ?to))
                        (at start (available ?empl))
                        (at start (not (driving ?empl ?trn)))
                        (over all (not (available ?empl))))
        :effect (and (at start (is_in ?empl ?from))
                     (at end (is_in ?empl ?to))
                     (at end (available ?empl))))
    
    (:durative-action board_transport
        :parameters (?empl - employee ?trs - transport ?loc - location)
        :duration (= ?duration 1)
        :condition (and (at start (is_in ?empl ?loc))
                        (at start (is_in ?trs ?loc))
                        (at start (not (driving ?empl)))
                        (at start (not (is_in ?empl ?trs)))

        )
        :effect (and 
            
        )
    )

    (:durative-action drive
        :parameters (?empl - employee ?trs - transport ?from - location ?to - location)
        :duration (= ?duration 10)
        :condition (and (at start (is_in ?empl ?trs))
                        (at start (is_in ?trs ?from))
                        (at start (driving ?empl ?trn))
                        (over all (driving ?empl))
                        (over all (not (available ?empl))))
        :effect (and (at start (not (is_in ?trs ?from)))
                     (at end (is_in ?empl ?to))
                     (at end (available ?empl)))
    )
)