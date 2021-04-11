(define (domain dock_fsm)

(:requirements :strips :typing :negative-preconditions :equality)
(:types
    location
    dock distribution_centre distributor - location
    
    vehicle
    work_vehicle distribution_vehicle - vehicle
    truck - work_vehicle
    van  - distribution_vehicle

    machine
    truck_crane - machine

    agent
    container
    cargo

    state
    idle_state dock_state distribution_state transportation_state - state
)

; un-comment following line if constants are needed
;(:constants ) 

(:predicates
    ; General
    (in ?x ?y)
    (adjacent ?loc1 - location ?loc2 - location)

    ; Vehicle related
    (loaded ?wkvhle - work_vehicle ?container - container)
    (loaded ?distvhle - distribution_vehicle ?cargo - cargo)
    (unloaded ?vehicle - vehicle)
    (unloaded ?machine - machine)
    (driver_available ?vehicle - vehicle)
    (passenger_available ?vehicle - vehicle)
    (driver ?driver - agent ?vehicle - vehicle)
    (passenger ?passenger - agent ?vehicle - vehicle)
    
    ; Machine related
    (operator_available ?machine - machine)
    (operating ?agt - agent ?machine - machine)

    ; State related
    (agent_state ?agt - agent ?ste - state)
)

; Actions

; Universal Actions
(:action walk
    :parameters (?agt - agent ?loc1 - location ?loc2 - location)
    :precondition (and
        (in ?agt ?loc2)
        (adjacent ?loc1 ?loc2)
    )
    :effect (and
        (not (in ?agt ?loc1))
        (in ?agt ?loc2)
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

; Transportation Actions

(:action board_driver
    :parameters (?agt - agent ?veh - vehicle ?loc - location ?ste - transportation_state)
    :precondition (and 
        (in ?agt ?loc)
        (in ?veh ?loc)
        (driver_available ?veh)
        (agent_state ?agt ?ste)
    )
    :effect (and 
        (not (in ?agt ?loc))
        (not (driver_available ?veh))
        (driver ?agt ?veh)
    )
)

(:action driver_disembark
    :parameters (?agt - agent ?veh - vehicle ?loc - location ?ste - transportation_state)
    :precondition (and 
        (in ?veh ?loc)
        (driver ?agt ?veh)
        (agent_state ?agt ?ste)
    )
    :effect (and 
        (in ?agt ?loc)
        (not (driver ?agt ?veh))
        (driver_available ?veh)
    )
)

(:action drive_vehicle
    :parameters (?agt - agent ?veh - vehicle ?loc1 - location ?loc2 - location ?ste - transportation_state)
    :precondition (and 
        (driver ?agt ?veh)
        (in ?veh ?loc1)
        (adjacent ?loc1 ?loc2)
        (agent_state ?agt ?ste)
    )
    :effect (and 
        (not (in ?veh ?loc1))
        (in ?veh ?loc2)
    )
)

; Dock Actions

(:action operate_machine
    :parameters (?machine - machine ?loc - location ?agt - agent ?ste - dock_state)
    :precondition (and 
        (in ?agt ?loc)
        (in ?machine ?loc)
        (operator_available ?machine)
        (agent_state ?agt ?ste)
    )
    :effect (and 
        (not (in ?agt ?loc))
        (operating ?agt ?machine)
    )
)

(:action disembark_machine
    :parameters (?machine - machine ?loc - location ?agt - agent ?ste - dock_state)
    :precondition (and 
        (in ?machine ?loc)
        (operating ?agt ?machine)
        (agent_state ?agt ?ste)
    )
    :effect (and 
        (in ?agt ?loc)
        (not (operating ?agt ?machine))
        (operator_available ?machine)
    )
)

; Dock and Transport actions

(:action load_truck
    :parameters (?container - container ?truck_crane - truck_crane ?truck - truck ?agt1 - agent ?agt2 - agent ?loc - location ?ste1 - dock_state ?ste2 - transportation_state)
    :precondition (and
        (in ?truck ?loc)
        (in ?truck_crane ?loc)
        (operating ?agt1 ?truck_crane)
        (driver ?agt2 ?truck)
        (in ?container ?loc)
        (unloaded ?truck)
        (agent_state ?agt1 ?ste1)
        (agent_state ?agt2 ?ste2)
    )
    :effect (and 
        (not (unloaded ?truck))
        (not (in ?container ?loc))
        (loaded ?truck ?container)
    )
)

(:action unload_truck
    :parameters (?container - container ?truck_crane - truck_crane ?truck - truck ?agt1 - agent ?agt2 - agent ?loc - location ?ste1 - dock_state ?ste2 - transportation_state)
    :precondition (and
        (in ?truck ?loc)
        (in ?truck_crane ?loc)
        (operating ?agt1 ?truck_crane)
        (driver ?agt2 ?truck)
        (loaded ?truck ?container)
        (agent_state ?agt1 ?ste1)
        (agent_state ?agt2 ?ste2)
    )
    :effect (and 
        (not (loaded ?truck ?container))
        (in ?container ?loc)
        (unloaded ?truck)
    )
)

; Distribution Centre actions

(:action load_van
    :parameters (?cargo - cargo ?van - van ?agt - agent ?dist - distribution_centre ?ste - distribution_state)
    :precondition (and 
        (in ?cargo ?dist)
        (in ?van ?dist)
        (in ?agt ?dist)
        (unloaded ?van)
        (agent_state ?agt ?ste)
    )
    :effect (and
        (not (unloaded ?van))
        (not (in ?cargo ?dist))
        (loaded ?van ?cargo)
    )
)

(:action unload_van
    :parameters (?cargo - cargo ?van - van ?agt - agent ?loc - location ?ste - distribution_state)
    :precondition (and 
        (in ?van ?loc)
        (loaded ?van ?cargo)
        (in ?agt ?loc)
        (agent_state ?agt ?ste)
    )
    :effect (and
        (not (loaded ?van ?cargo))
        (unloaded ?van)
        (in ?cargo ?loc)
    )
)

(:action unload_container
    :parameters (?container - container ?cargo - cargo ?agt - agent ?dist - distribution_centre ?ste - distribution_state)
    :precondition (and 
        (in ?container ?dist)
        (in ?agt ?dist)
        (in ?cargo ?container)
        (agent_state ?agt ?ste)
    )
    :effect (and
        (in ?cargo ?dist)
        (not (in ?cargo ?container))
    )
)

; Change states

(:action change_out_state
    :parameters (?agent - agent ?state - state ?idle - idle_state)
    :precondition (and 
        (agent_state ?agent ?state)
    )
    :effect (and 
        (not (agent_state ?agent ?state))
        (agent_state ?agent ?idle)
    )
)

(:action change_into_state
    :parameters (?agent - agent ?state - state ?idle - idle_state)
    :precondition (and
        (agent_state ?agent ?idle)
    )
    :effect (and 
        (not (agent_state ?agent ?idle))
        (agent_state ?agent ?state)
    )
)

)