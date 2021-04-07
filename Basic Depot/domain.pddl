(define (domain dock)

(:requirements :strips :typing :negative-preconditions :equality)

(:types
    location
    dock distribution_centre distributor - location
    ship
    
    workVehicles
    truck truck-crane - workVehicles

    machine
    crane - machine

    agent
    container
    cargo
)

(:predicates
    (in ?x ?y)
    (adjacent ?loc1 - location ?loc2 - location)
    (adjacent ?loc1 - dock ?loc2 - ship)
    (loaded ?veh - workVehicles ?con - container)
    (loaded ?veh - crane ?cgo - cargo)
    (unloaded ?veh - workVehicles)
    (stored ?con - container ?loc - location)
    (stored ?con - container ?ship - ship)
    (available ?x)
)

; ACTIONS

;General actions
(:action walk
    :parameters (?agt - agent ?loc1 - location ?loc2 - location)
    :precondition (and 
        (in ?agt ?loc1)
        (adjacent ?loc1 ?loc2)
    )
    :effect (and 
        (not (in ?agt ?loc1))
        (in ?agt ?loc2)
    )
)

(:action get_into_vehicle
    :parameters (?agt - agent ?wvh - workVehicles ?loc - location)
    :precondition (and 
        (in ?agt ?loc)
        (in ?wvh ?loc)
        (not (in ?agt ?wvh))
        (available ?wvh)
    )
    :effect (and 
        (in ?agt ?wvh)
        (not (in ?agt ?loc))
        (not (available ?wvh))
    )
)

(:action get_out_of_vehicle
    :parameters (?agt - agent ?wvh - workVehicles ?loc - location)
    :precondition (and 
        (in ?agt ?wvh)
        (in ?wvh ?loc)
        (not (in ?agt ?loc))
        (not (available ?wvh))
    )
    :effect (and 
        (not (in ?agt ?wvh))
        (in ?agt ?loc)
        (available ?wvh)
    )
)

(:action drive
    :parameters (?agt - agent ?wvh - truck ?loc1 - location ?loc2 - location)
    :precondition (and 
        (in ?agt ?wvh)
        (in ?wvh ?loc1)
        (adjacent ?loc1 ?loc2)
    )
    :effect (and 
        (not (in ?wvh ?loc1))
        (in ?wvh ?loc2)
    )
)


;Dock
(:action lift_cargo
    :parameters (?agt - agent ?tkcrn - truck-crane ?loc - location ?con - container)
    :precondition (and 
        (in ?agt ?tkcrn)
        (in ?tkcrn ?loc)
        (stored ?con ?loc)
        (unloaded ?tkcrn)rane actions
        (not (stored ?con ?loc))
        (not (unloaded ?tkcrn))
        (loaded ?tkcrn ?con)
    )
)

(:action drop_cargo
    :parameters (?agt - agent ?tkcrn - truck-crane ?loc - location ?con - container)
    :precondition (and 
        (in ?agt ?tkcrn)
        (in ?tkcrn ?loc)
        (loaded ?tkcrn ?con)
    )
    :effect (and 
        (not (loaded ?tkcrn ?con))
        (stored ?con ?loc)
        (unloaded ?tkcrn)
    )
)

(:action load_truck
    :parameters (?agt1 - agent ?agt2 - agent ?tkcrn - truck-crane ?trk - truck ?con - container ?dock - location)
    :precondition (and 
        (in ?agt1 ?tkcrn)
        (in ?agt2 ?trk)
        (in ?tkcrn ?dock)
        (in ?trk ?dock)
        (loaded ?tkcrn ?con)
        (unloaded ?trk)
    )
    :effect (and 
        (not (loaded ?tkcrn ?con))
        (not (unloaded ?trk))
        (unloaded ?tkcrn)
        (loaded ?trk ?con)
    )
)

(:action unload_truck
    :parameters (?agt1 - agent ?agt2 - agent ?tkcrn - truck-crane ?trk - truck ?con - container ?dock - location)
    :precondition (and 
        (in ?agt1 ?tkcrn)
        (in ?agt2 ?trk)
        (in ?tkcrn ?dock)
        (in ?trk ?dock)
        (loaded ?trk ?con)
        (unloaded ?tkcrn)
    )
    :effect (and 
        (not (loaded ?trk ?con))
        (not (unloaded ?tkcrn))
        (unloaded ?trk)
        (loaded ?tkcrn ?con)
    )
)

(:action unload_ship
    :parameters (?agt1 - agent ?agt2 - agent ?crn - crane ?dock - dock ?ship - ship ?con - container)
    :precondition (and 
        (in ?agt1 ?dock)
        (in ?agt2 ?crn)
        (in ?crn ?dock)
        (adjacent ?dock ?ship)
        (stored ?con ?ship)
    )
    :effect (and 
        (not (stored ?con ?ship))
        (stored ?con ?dock)
    )
)

(:action unpack_cargo
    :parameters (?con - container ?cgo - cargo ?agent - agent ?dist - distribution_centre)
    :precondition (and 
        (in ?cgo ?con)
        (stored ?con ?dist)
        (in ?agent ?dist)
    )
    :effect (and 
        (not (in ?cgo ?con))
        (in ?cgo ?dist)
    )
)



)