(define (domain dock)

(:requirements :strips :typing :negative-preconditions :equality)

(:types
    location
    dock port distributor - location
    ship
    truck
    crane
    agent
    container
    cargo
)

(:predicates
    ; Map Related
    (adjacent ?loc1 - location ?loc2 - location)
    (next ?ship - ship ?dk - dock)

    ;  General Prep
    (in ?x ?y)
    (driver-available ?trk - truck)
    (passenger-available ?trk - truck)
    (operator-available ?crn - crane)
    (driving ?agt - agent ?trk - truck)
    (passenger ?agt - agent ?trk - truck)
    (operating ?agt - agent ?crn - crane)

    ; Crane Prep
    (loaded ?x)
    (delivered ?cgo - cargo ?dist - distributor)

    (idle ?agt)
    (dock-state ?agt)
    (transport-state ?agt)
)

(:action board-driver
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :precondition (and 
        (in ?agt ?loc)
        (in ?trk ?loc) 
        (driver-available ?trk)
        (transport-state ?agt)
    )
    :effect (and
        (not (in ?agt ?loc))
        (not (driver-available ?trk))
        (driving ?agt ?trk)
    )
)

(:action drive-truck
    :parameters (?agt - agent ?trk - truck ?loc1 - location ?loc2 - location)
    :precondition (and 
        (in ?trk ?loc1)
        (driving ?agt ?trk) 
        (adjacent ?loc1 ?loc2)
        (transport-state ?agt)
    )
    :effect (and
        (not (in ?trk ?loc1))
        (in ?trk ?loc2)
    )
)

(:action disembark-driver
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :precondition (and 
        (driving ?agt ?trk)
        (in ?trk ?loc) 
        (transport-state ?agt)
    )
    :effect (and
        (not (driving ?agt ?trk))
        (driver-available ?trk)
        (in ?agt ?loc)
    )
)

(:action board-passenger
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :precondition (and 
        (in ?agt ?loc)
        (in ?trk ?loc) 
        (passenger-available ?trk)
    )
    :effect (and
        (not (in ?agt ?loc))
        (not (passenger-available ?trk))
        (passenger ?agt ?trk)
    )
)

(:action disembark-passenger
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :precondition (and 
        (passenger ?agt ?trk)
        (in ?trk ?loc) 
    )
    :effect (and
        (not (passenger ?agt ?trk))
        (passenger-available ?trk)
        (in ?agt ?loc)
    )
)

(:action operate-crane
    :parameters (?agt - agent ?crn - crane ?loc - location)
    :precondition (and 
        (in ?crn ?loc)
        (in ?agt ?loc)
        (operator-available ?crn)
        (dock-state ?agt)
    )
    :effect (and
        (not (in ?agt ?loc))
        (not (operator-available ?crn))
        (operating ?agt ?crn)
    )
)

(:action disembark-crane
    :parameters (?agt - agent ?crn - crane ?loc - location)
    :precondition (and 
        (in ?crn ?loc)
        (operating ?agt ?crn)
        (dock-state ?agt)
    )
    :effect (and
        (not (operating ?agt ?crn))
        (operator-available ?crn)
        (in ?agt ?loc)
    )
)

(:action unload-ship
    :parameters (?agt - agent ?crn - crane ?shp - ship ?con - container ?dk - dock)
    :precondition (and 
        (in ?crn ?dk)
        (next ?shp ?dk)
        (operating ?agt ?crn)
        (in ?con ?shp)
        (not (loaded ?crn))
        (dock-state ?agt)
    )
    :effect (and 
        (loaded ?crn)
        (not (in ?con ?shp))
        (in ?con ?crn)
    )
)

(:action unload-container-to-dock
    :parameters (?agt - agent ?crn - crane ?dk - dock ?con - container)
    :precondition (and 
        (in ?crn ?dk)
        (operating ?agt ?crn)
        (loaded ?crn)
        (in ?con ?crn)
        (dock-state ?agt)
    )
    :effect (and 
        (in ?con ?dk)
        (not (loaded ?crn))
        (not (in ?con ?crn))
    )
)

(:action crane-unload-container-to-truck
    :parameters (?agt1 - agent ?agt2 - agent ?crn - crane ?trk - truck ?con - container ?dk - dock)
    :precondition (and 
        (in ?crn ?dk)
        (in ?trk ?dk)
        (operating ?agt1 ?crn)
        (driving ?agt2 ?trk)
        (loaded ?crn)
        (in ?con ?crn)
        (not (loaded ?trk))
        (dock-state ?agt1)
        (transport-state ?agt2)
    )
    :effect (and 
        (not (loaded ?crn))
        (not (in ?con ?crn))
        (loaded ?trk)
        (in ?con ?trk)
    )
)

(:action crane-unload-truck-container
    :parameters (?agt1 - agent ?agt2 - agent ?crn - crane ?trk - truck ?con - container ?dk - dock)
    :precondition (and 
        (in ?crn ?dk)
        (in ?trk ?dk)
        (operating ?agt1 ?crn)
        (driving ?agt2 ?trk)
        (loaded ?trk)
        (in ?con ?trk)
        (not (loaded ?crn))
        (dock-state ?agt1)
        (transport-state ?agt2)
    )
    :effect (and 
        (not (loaded ?trk))
        (not (in ?con ?trk))
        (loaded ?crn)
        (in ?con ?crn)
    )
)

(:action unload-cargo
    :parameters (?agt - agent ?trk - truck ?con - container ?cgo - cargo ?dist - distributor)
    :precondition (and 
        (in ?trk ?dist)
        (in ?con ?trk)
        (in ?cgo ?con)
        (driving ?agt ?trk)
        (transport-state ?agt)
    )
    :effect (and 
        (not (in ?cgo ?con))
        (delivered ?cgo ?dist)
    )
)

(:action dock-state-to-idle-state
    :parameters (?agt - agent)
    :precondition (and 
        (dock-state ?agt)
    )
    :effect (and 
        (not (dock-state ?agt))
        (idle ?agt)
    )
)

(:action idle-state-to-dock-state
    :parameters (?agt - agent)
    :precondition (and 
        (idle ?agt)
    )
    :effect (and 
        (not (idle ?agt))
        (dock-state ?agt)
    )
)

(:action transport-state-to-idle-state
    :parameters (?agt - agent)
    :precondition (and 
        (transport-state ?agt)
    )
    :effect (and 
        (not (transport-state ?agt))
        (idle ?agt)
    )
)

(:action idle-state-to-transport-state
    :parameters (?agt - agent)
    :precondition (and 
        (idle ?agt)
    )
    :effect (and 
        (not (idle ?agt))
        (transport-state ?agt)
    )
)



)