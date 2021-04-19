(define (domain dock)

(:requirements :strips :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types 
    location
    dock port distribution_centre distributor - location
    ; ship

    vehicle
    truck van - vehicle

    machine
    crane truck_crane - machine

    agent
    container
    cargo
)

(:predicates
    ; General
    (agent_in ?x - agent ?y - location)
    (vehicle_in ?x - vehicle ?y - location)
    (machine_in ?x - machine ?y - location)
    (container_in ?x - container ?y - location)
    (container_stored ?x - container ?y - ship)
    (cargo_stored ?x - cargo ?contain - container)
    (cargo_in ?x - cargo ?loc - location)
    (adjacent ?x - location ?y - location)
    (next ?ship - ship ?y - location)
    
    ; Vehicle related
    (truck_loaded ?x - truck ?y - container)
    (van_loaded ?x - van ?y - cargo)
    (machine_loaded ?x - machine ?y - container)
    (vehicle_unloaded ?x - vehicle)
    (machine_unloaded ?x - machine)
    (driver_available ?veh - vehicle)
    (passenger_available ?veh - vehicle)
    (driver ?agt - agent ?veh - vehicle)
    (passenger ?agt - agent ?veh - vehicle)

    ; Machine related
    (operator_available ?mach - machine)
    (operating ?agt - agent ?mach - machine)

    ; Goal related
    (delivered ?cargo - cargo ?dist - distributor)
)

; Actions
(:durative-action board-driver
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (agent_in ?agt ?loc)
            (driver_available ?veh)
        ))
        (over all (and 
            (vehicle_in ?veh ?loc)
            (driver_available ?veh)
        ))
    )
    :effect (and 
        (at start (and 
            (not (agent_in ?agt ?loc))
        ))
        (at end (and 
            (not (driver_available ?veh))
            (driver ?agt ?veh)
        ))
    )
)

(:durative-action driver-disembark
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and
            (driver ?agt ?veh)
            (vehicle_in ?veh ?loc)
        ))
        (over all (and 
            (vehicle_in ?veh ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (driver ?agt ?veh))
        ))
        (at end (and 
            (agent_in ?agt ?loc)
            (driver_available ?veh)
        ))
    )
)

(:durative-action board-passenger
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (passenger_available ?veh)
            (agent_in ?agt ?loc)
        ))
        (over all (and 
            (vehicle_in ?veh ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (agent_in ?agt ?loc))
        ))
        (at end (and 
            (not (passenger_available ?veh))
            (passenger ?agt ?veh)
        ))
    )
)

(:durative-action disembark-passenger
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (passenger ?agt ?veh)
        ))
        (over all (and 
            (vehicle_in ?veh ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (passenger ?agt ?veh))
        ))
        (at end (and 
            (agent_in ?agt ?loc)
            (passenger_available ?veh)
        ))
    )
)

(:durative-action drive
    :parameters (?agt - agent ?veh - vehicle ?loc1 - location ?loc2 - location)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (vehicle_in ?veh ?loc1)
            (driver ?agt ?veh)
        ))
        (over all (and 
            (driver ?agt ?veh)
            (adjacent ?loc1 ?loc2)
        ))
    )
    :effect (and 
        (at start (and 
            (not (vehicle_in ?veh ?loc1))
        ))
        (at end (and 
            (vehicle_in ?veh ?loc2)
        ))
    )
)

; Machine Actions

(:durative-action board-machine
    :parameters (?agt - agent ?mach - machine ?loc - location)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (agent_in ?agt ?loc)
            (operator_available ?mach)
        ))
        (over all (and 
            (machine_in ?mach ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (agent_in ?agt ?loc))
            (not (operator_available ?mach))
        ))
        (at end (and 
            (operating ?agt ?mach)
        ))
    )
)

(:durative-action disembark-machine
    :parameters (?agt - agent ?mach - machine ?loc - location)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (operating ?agt ?mach)
        ))
        (over all (and 
            (machine_in ?mach ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (operating ?agt ?mach))
        ))
        (at end (and 
            (agent_in ?agt ?loc)
            (operator_available ?mach)
        ))
    )
)

; Crane Actions

(:durative-action unload-ship
    :parameters (?agt - agent ?crane - crane ?contain - container ?dock - dock ?ship - ship)
    :duration (= ?duration 15)
    :condition (and 
        (at start (and 
            (operating ?agt ?crane)
            (machine_in ?crane ?dock)
            (container_stored ?contain ?ship)
            (machine_unloaded ?crane)
            (next ?ship ?dock)
        ))
        (over all (and 
            (operating ?agt ?crane)
            (next ?ship ?dock)
        ))
    )
    :effect (and 
        (at start (and 
            (not (container_stored ?contain ?ship))
        ))
        (at end (and 
            (not (machine_unloaded ?crane))
            (machine_loaded ?crane ?contain)
        ))
    )
)

(:durative-action unload-crane
    :parameters (?agt - agent ?crane - crane ?contain - container ?dock - dock)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (operating ?agt ?crane)
            (machine_in ?crane ?dock)
            (machine_loaded ?crane ?contain)
        ))
        (over all (and 
            (operating ?agt ?crane)
            (machine_in ?crane ?dock)
        ))
    )
    :effect (and 
        (at start (and 
            (not (machine_loaded ?crane ?contain))
        ))
        (at end (and
            (container_in ?contain ?dock)
            (machine_unloaded ?crane)
        ))
    )
)

; Truck Crane

(:durative-action lift-container
    :parameters (?agt - agent ?trkcrn - truck_crane ?contain - container ?loc - location)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (container_in ?contain ?loc)
            (machine_unloaded ?trkcrn)
        ))
        (over all (and 
            (machine_in ?trkcrn ?loc)
            (operating ?agt ?trkcrn)
        ))
    )
    :effect (and 
        (at start (and 
            (not (container_in ?contain ?loc))
        ))
        (at end (and 
            (not (machine_unloaded ?trkcrn))
            (machine_loaded ?trkcrn ?contain)
        ))
    )
)

(:durative-action drop-container
    :parameters (?agt - agent ?trkcrn - truck_crane ?contain - container ?loc - location)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (machine_loaded ?trkcrn ?contain)
        ))
        (over all (and 
            (machine_in ?trkcrn ?loc)
            (operating ?agt ?trkcrn)
        ))
    )
    :effect (and 
        (at start (and 
            (not (machine_loaded ?trkcrn ?contain))
        ))
        (at end (and 
            (container_in ?contain ?loc)
        ))
    )
)

(:durative-action load-truck
    :parameters (?agt1 - agent ?agt2 - agent ?contain - container ?trkcrn - truck_crane ?trk - truck ?loc - location)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (machine_loaded ?trkcrn ?contain)
            (vehicle_unloaded ?trk)
        ))
        (over all (and 
            (operating ?agt1 ?trkcrn)
            (driver ?agt2 ?trk)
            (vehicle_in ?trk ?loc)
            (machine_in ?trkcrn ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (machine_loaded ?trkcrn ?contain))
        ))
        (at end (and 
            (not (vehicle_unloaded ?trk))
            (truck_loaded ?trk ?contain)
            (machine_unloaded ?trkcrn)
        ))
    )
)

(:durative-action unload-truck
    :parameters (?agt1 - agent ?agt2 - agent ?contain - container ?trkcrn - truck_crane ?trk - truck ?loc - location)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (machine_unloaded ?trkcrn)
            (truck_loaded ?trk ?contain)
        ))
        (over all (and 
            (operating ?agt1 ?trkcrn)
            (driver ?agt2 ?trk)
            (vehicle_in ?trk ?loc)
            (machine_in ?trkcrn ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (truck_loaded ?trk ?contain))
        ))
        (at end (and 
            (not (machine_unloaded ?trkcrn))
            (vehicle_unloaded ?trk)
            (machine_loaded ?trkcrn ?contain)
        ))
    )
)

; Distribution Actions

(:durative-action unload-container
    :parameters (?agt - agent ?contain - container ?cargo - cargo ?loc - location)
    :duration (= ?duration 2)
    :condition (and 
        (at start (and 
            (cargo_stored ?cargo ?contain)
        ))
        (over all (and
            (agent_in ?agt ?loc)
            (container_in ?contain ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (cargo_stored ?cargo ?contain))
        ))
        (at end (and 
            (cargo_in ?cargo ?loc)
        ))
    )
)

(:durative-action load-van
    :parameters (?agt - agent ?van - van ?cargo - cargo ?loc - location)
    :duration (= ?duration 3)
    :condition (and 
        (at start (and 
            (cargo_in ?cargo ?loc)
        ))
        (over all (and 
            (agent_in ?agt ?loc)
            (vehicle_in ?van ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (cargo_in ?cargo ?loc))
        ))
        (at end (and 
            (van_loaded ?van ?cargo)
        ))
    )
)

(:durative-action unload-van
    :parameters (?agt - agent ?van - van ?cargo - cargo ?loc - location)
    :duration (= ?duration 3)
    :condition (and 
        (at start (and 
            (van_loaded ?van ?cargo)
        ))
        (over all (and 
            (agent_in ?agt ?loc)
            (vehicle_in ?van ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (van_loaded ?van ?cargo))
        ))
        (at end (and 
            (cargo_in ?cargo ?loc)
        ))
    )
)

(:durative-action deliver-cargo
    :parameters (?agt - agent ?van - van ?cargo - cargo ?loc - distributor)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (van_loaded ?van ?cargo)
        ))
        (over all (and 
            (agent_in ?agt ?loc)
            (vehicle_in ?van ?loc)
        ))
    )
    :effect (and 
        (at start (and 
            (not (van_loaded ?van ?cargo))
        ))
        (at end (and 
            (delivered ?cargo ?loc)
        ))
    )
)

)