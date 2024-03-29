(define (domain dock)

(:requirements :strips :typing :negative-preconditions :equality)
(:types
    location
    dock port distribution_centre distributor - location
    ship
    
    vehicle
    truck van  - vehicle

    machine
    crane truck_crane - machine

    agent
    container
    cargo
)

; un-comment following line if constants are needed
;(:constants ) 

(:predicates
    ; General
    (in ?x ?y)
    (adjacent ?x ?y)

    ; Vehicle related
    (loaded ?x ?y)
    (unloaded ?x)
    (driver_available ?vehicle - vehicle)
    (passenger_available ?vehicle - vehicle)
    (driver ?driver - agent ?vehicle - vehicle)
    (passenger ?passenger - agent ?vehicle - vehicle)
    
    ; Machine related
    (operator_available ?machine - machine)
    (operating ?agt - agent ?machine - machine)

    ; Goal related (to reduce the number of possible goal states with delivered)
    (delivered ?cargo - cargo ?dist - distributor)
)

; Actions

; General Actions
(:action board_driver
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :precondition (and 
        (in ?agt ?loc)
        (in ?veh ?loc)
        (driver_available ?veh)
    )
    :effect (and 
        (not (in ?agt ?loc))
        (not (driver_available ?veh))
        (driver ?agt ?veh)
    )
)

(:action board_passenger
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :precondition (and 
        (in ?agt ?loc)
        (in ?veh ?loc)
        (passenger_available ?veh)
    )
    :effect (and 
        (not (in ?agt ?loc))
        (not (passenger_available ?veh))
        (passenger ?agt ?veh)
    )
)

(:action driver_disembark
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :precondition (and 
        (in ?veh ?loc)
        (driver ?agt ?veh)
    )
    :effect (and 
        (in ?agt ?loc)
        (not (driver ?agt ?veh))
        (driver_available ?veh)
    )
)

(:action passenger_disembark
    :parameters (?agt - agent ?veh - vehicle ?loc - location)
    :precondition (and 
        (in ?veh ?loc)
        (passenger ?agt ?veh)
    )
    :effect (and 
        (in ?agt ?loc)
        (not (passenger ?agt ?veh))
        (passenger_available ?veh)
    )
)

(:action drive_vehicle
    :parameters (?agt - agent ?veh - vehicle ?loc1 - location ?loc2 - location)
    :precondition (and 
        (driver ?agt ?veh)
        (in ?veh ?loc1)
        (adjacent ?loc1 ?loc2)
    )
    :effect (and 
        (not (in ?veh ?loc1))
        (in ?veh ?loc2)
    )
)

; Dock Actions
(:action operate_machine
    :parameters (?machine - machine ?loc - location ?agt - agent)
    :precondition (and 
        (in ?agt ?loc)
        (in ?machine ?loc)
        (operator_available ?machine)
    )
    :effect (and 
        (not (in ?agt ?loc))
        (operating ?agt ?machine)
    )
)

(:action disembark_machine
    :parameters (?machine - machine ?loc - location ?agt - agent)
    :precondition (and 
        (in ?machine ?loc)
        (operating ?agt ?machine)
    )
    :effect (and 
        (in ?agt ?loc)
        (not (operating ?agt ?machine))
        (operator_available ?machine)
    )
)

(:action lift_container
    :parameters (?truck_crane - truck_crane ?container - container ?agt - agent ?loc - location)
    :precondition (and 
        (in ?container ?loc)
        (in ?truck_crane ?loc)
        (operating ?agt ?truck_crane)
        (unloaded ?truck_crane)
    )
    :effect (and 
        (not (unloaded ?truck_crane))
        (not (in ?container ?loc))
        (loaded ?truck_crane ?container)
    )
)

(:action drop_container
    :parameters (?truck_crane - truck_crane ?container - container ?agt - agent ?loc - location)
    :precondition (and 
        (in ?truck_crane ?loc)
        (operating ?agt ?truck_crane)
        (loaded ?truck_crane ?container)
    )
    :effect (and 
        (not (loaded ?truck_crane ?container))
        (unloaded ?truck_crane)
        (in ?container ?loc)
    )
)

(:action load_truck
    :parameters (?container - container ?truck_crane - truck_crane ?truck - truck ?agt1 - agent ?agt2 - agent ?loc - location)
    :precondition (and
        (in ?truck ?loc)
        (in ?truck_crane ?loc)
        (operating ?agt1 ?truck_crane)
        (loaded ?truck_crane ?container)
        (unloaded ?truck)
        (driver ?agt2 ?truck)
    )
    :effect (and 
        (not (unloaded ?truck))
        (not (loaded ?truck_crane ?container))
        (loaded ?truck ?container)
        (unloaded ?truck_crane)
    )
)

(:action unload_truck
    :parameters (?container - container ?truck_crane - truck_crane ?truck - truck ?agt1 - agent ?agt2 - agent ?loc - location)
    :precondition (and
        (in ?truck ?loc)
        (in ?truck_crane ?loc)
        (operating ?agt1 ?truck_crane)
        (loaded ?truck ?container)
        (unloaded ?truck_crane)
        (driver ?agt2 ?truck)
    )
    :effect (and 
        (not (unloaded ?truck_crane))
        (not (loaded ?truck ?container))
        (loaded ?truck_crane ?container)
        (unloaded ?truck)
    )
)

(:action unload_container
    :parameters (?container - container ?cargo - cargo ?agt - agent ?dist - distribution_centre)
    :precondition (and 
        (in ?container ?dist)
        (in ?agt ?dist)
        (in ?cargo ?container)
    )
    :effect (and
        (in ?cargo ?dist)
        (not (in ?cargo ?container))
    )
)

(:action load_van
    :parameters (?cargo - cargo ?van - van ?agt - agent ?dist - distribution_centre)
    :precondition (and 
        (in ?cargo ?dist)
        (in ?van ?dist)
        (in ?agt ?dist)
        (unloaded ?van)
    )
    :effect (and
        (not (unloaded ?van))
        (not (in ?cargo ?dist))
        (loaded ?van ?cargo)
    )
)

(:action unload_van
    :parameters (?cargo - cargo ?van - van ?agt - agent ?loc - location)
    :precondition (and 
        (in ?van ?loc)
        (loaded ?van ?cargo)
        (in ?agt ?loc)
    )
    :effect (and
        (not (loaded ?van ?cargo))
        (unloaded ?van)
        (in ?cargo ?loc)
    )
)

(:action deliver_cargo
    :parameters (?cargo - cargo ?van - van ?agt - agent ?loc - distributor)
    :precondition (and 
        (in ?van ?loc)
        (loaded ?van ?cargo)
        (in ?agt ?loc)
    )
    :effect (and
        (not (loaded ?van ?cargo))
        (unloaded ?van)
        (delivered ?cargo ?loc)
    )
)

; Crane actions
(:action unload_ship
    :parameters (?ship - ship ?crane - crane ?container - container ?agt - agent ?dock - dock)
    :precondition (and
        (in ?container ?ship)
        (adjacent ?ship ?dock)
        (in ?crane ?dock)
        (operating ?agt ?crane)
        (unloaded ?crane)
    )
    :effect (and 
        (not (in ?container ?ship))
        (loaded ?crane ?container)
        (not (unloaded ?crane))
    )
)

(:action unload_crane
    :parameters (?crane - crane ?container - container ?agt - agent ?dock - dock)
    :precondition (and 
        (in ?crane ?dock)
        (loaded ?crane ?container)
        (operating ?agt ?crane)
    )
    :effect (and 
        (not (loaded ?crane ?container))
        (in ?container ?dock)
    )
)

)