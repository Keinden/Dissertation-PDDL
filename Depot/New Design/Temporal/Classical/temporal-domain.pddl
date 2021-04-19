(define (domain temporal-dock)

(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

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
    ; Map related
    (adjacent ?loc1 - location ?loc2 - location)
    (next ?ship - ship ?dk - dock)

    ; Location of things
    (truck-in ?trk - truck ?loc - location)
    (crane-in ?crn - crane ?loc - location)
    (container-in ?con - container ?shp - ship)
    (container-stored ?con - container ?loc - location)
    (cargo-in ?cgo - cargo ?con - container)
    (agent-in ?agt - agent ?loc - location)

    ; Truck and Crane locks
    (driver-available ?trk - truck)
    (passenger-available ?trk - truck)
    (operator-available ?crn - crane)
    (driving ?agt - agent ?trk - truck)
    (passenger ?agt - agent ?trk - truck)
    (operating ?agt - agent ?crn - crane)
    (crane-free ?crn - crane)
    (crane-holding ?crn - crane ?con - container)
    (truck-free ?trk - truck)
    (truck-holding ?trk - truck ?con - container)
    (unloading-available ?trk - truck)

    ; Goal lock
    (delivered ?cgo - cargo ?dist - distributor)

)

(:durative-action board-driver
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (agent-in ?agt ?loc)
            (driver-available ?trk)
        ))
        (over all (and 
            (truck-in ?trk ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (agent-in ?agt ?loc))
            (not (driver-available ?trk))
        ))
        (at end (and 
            (driving ?agt ?trk)
        ))
    )
)

(:durative-action drive-truck
    :parameters (?agt - agent ?trk - truck ?loc1 - location ?loc2 - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (truck-in ?trk ?loc1)
        ))
        (over all (and 
            (adjacent ?loc1 ?loc2)
            (driving ?agt ?trk)
        ))
    )
    :effect (and 
        (at start (and 
            (not (truck-in ?trk ?loc1))
        ))
        (at end (and 
            (truck-in ?trk ?loc2)
        ))
    )
)

(:durative-action disembark-driver
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (driving ?agt ?trk)
        ))
        (over all (and 
            (truck-in ?trk ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (driving ?agt ?trk))
        ))
        (at end (and 
            (driver-available ?trk)
            (agent-in ?agt ?loc)
        ))
    )
)

(:durative-action board-passenger
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (agent-in ?agt ?loc)
            (passenger-available ?trk)
        ))
        (over all (and 
            (truck-in ?trk ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (agent-in ?agt ?loc))
            (not (passenger-available ?trk))
        ))
        (at end (and 
            (passenger ?agt ?trk)
        ))
    )
)

(:durative-action disembark-passenger
    :parameters (?agt - agent ?trk - truck ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (passenger ?agt ?trk)
        ))
        (over all (and 
            (truck-in ?trk ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (passenger ?agt ?trk))
        ))
        (at end (and 
            (passenger-available ?trk)
            (agent-in ?agt ?loc)
        ))
    )
)

(:durative-action operate-crane
    :parameters (?agt - agent ?crn - crane ?loc - location)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (operator-available ?crn)
            (agent-in ?agt ?loc)
        ))
        (over all (and 
            (crane-in ?crn ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (agent-in ?agt ?loc))
            (not (operator-available ?crn))
        ))
        (at end (and 
            (operating ?agt ?crn)
        ))
    )
)

(:durative-action disembark-crane
    :parameters (?agt - agent ?crn - crane ?loc - location)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (operating ?agt ?crn)
        ))
        (over all (and 
            (crane-in ?crn ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (operating ?agt ?crn))
        ))
        (at end (and 
            (operator-available ?crn)
            (agent-in ?agt ?loc)
        ))
    )
)

(:durative-action unload-ship
    :parameters (?agt - agent ?crn - crane ?shp - ship ?con - container ?dk - dock)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (container-in ?con ?shp)
            (crane-free ?crn)
        ))
        (over all (and 
            (operating ?agt ?crn)
            (crane-in ?crn ?dk)
            (next ?shp ?dk)
        ))
    )
    :effect (and 
        (at start (and 
            (not (crane-free ?crn))
            (not (container-in ?con ?shp))
        ))
        (at end (and 
            (crane-holding ?crn ?con)
        ))
    )
)

(:durative-action unload-container-to-dock
    :parameters (?agt - agent ?crn - crane ?dk - dock ?con - container)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (crane-holding ?crn ?con)
        ))
        (over all (and 
            (crane-in ?crn ?dk)
            (operating ?agt ?crn)
        ))
    )
    :effect (and 
        (at start (and 
            (not (crane-holding ?crn ?con))
        ))
        (at end (and 
            (container-stored ?con ?dk)
            (crane-free ?crn)
        ))
    )
)

(:durative-action crane-unload-container-to-truck
    :parameters (?agt1 - agent ?agt2 - agent ?crn - crane ?trk - truck ?con - container ?dk - dock)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (crane-holding ?crn ?con)
            (truck-free ?trk)
        ))
        (over all (and 
            (crane-in ?crn ?dk)
            (truck-in ?trk ?dk)
            (operating ?agt1 ?crn)
            (driving ?agt2 ?trk)
        ))
    )
    :effect (and 
        (at start (and 
            (not (truck-free ?trk))
            (not (crane-holding ?crn ?con))
        ))
        (at end (and 
            (truck-holding ?trk ?con)
            (crane-free ?crn)
            (unloading-available ?trk)
        ))
    )
)

(:durative-action crane-unload-truck-container
    :parameters (?agt1 - agent ?agt2 - agent ?crn - crane ?trk - truck ?con - container ?dk - dock)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (crane-free ?crn)
            (truck-holding ?trk ?con)
        ))
        (over all (and 
            (operating ?agt1 ?crn)
            (driving ?agt2 ?trk)
            (crane-in ?crn ?dk)
            (truck-in ?trk ?dk)
        ))
    )
    :effect (and 
        (at start (and 
            (not (crane-free ?crn))
            (not (truck-holding ?trk ?con))
        ))
        (at end (and 
            (truck-free ?trk)
            (crane-holding ?crn ?con)
        ))
    )
)

(:durative-action unload-cargo
    :parameters (?agt - agent ?trk - truck ?con - container ?cgo - cargo ?dist - distributor)
    :duration (= ?duration 2)
    :condition (and 
        (at start (and 
            (cargo-in ?cgo ?con)
            (unloading-available ?trk)
        ))
        (over all (and 
            (driving ?agt ?trk)
            (truck-in ?trk ?dist)
            (truck-holding ?trk ?con)
        ))
    )
    :effect (and 
        (at start (and 
            (not (cargo-in ?cgo ?con))
            (not (unloading-available ?trk))
        ))
        (at end (and 
            (delivered ?cgo ?dist)
            (unloading-available ?trk)
        ))
    )
)


)