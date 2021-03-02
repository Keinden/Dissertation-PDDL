(define (domain dockyard)
    (:requirements :strips :equality :typing :negative-preconditions)
    (:types
        bridge dock platform - location
        robot worker - agent
        truck - transport
        ship crane - vehicle
        cargo
        idle get_cargo load_transport drive_transport unload_transport - state
    )

    (:predicates (is_in ?x ?y)
                 (state ?agent - agent ?state - state)
                 (path ?x - location ?y - location)

                 ; CHECKS
                 (empty ?x)
    )
    
    ; STATES
    (:action change_into_state
        :parameters (?agent - agent
                     ?state1 - idle
                     ?state2 - state
                    )
        :precondition (and
                        (state ?agent ?state1)
                        (not (state ?agent ?state2))    
        )
        :effect (and
                     (state ?agent ?state2)
                     (not (state ?agent ?state1))
        )
    )
    
    (:action change_out_of_state
        :parameters (?agent - agent
                     ?state1 - state
                     ?state2 - idle
                    )
        :precondition (and
                        (state ?agent ?state1)
                        (not (state ?agent ?state2))    
                      )
        :effect (and
                     (state ?agent ?state2)
                     (not (state ?agent ?state1))
        )
    )

    ; SHIP UNLOAD
    (:action ship_unload
        :parameters (?agent - agent
                     ?state - get_cargo
                     ?crane - crane
                     ?ship - ship
                     ?dock - dock
                     ?platform - platform
                     ?cargo - cargo
                    )
        :precondition (and
                        (state ?agent ?state)
                        (is_in ?agent ?crane)
                        (is_in ?crane ?dock)
                        (is_in ?ship ?dock)
                        (is_in ?cargo ?ship)
                        (is_in ?platform ?dock)
                        (empty ?platform)
                      )
        :effect (and
                    (not (is_in ?cargo ?ship))
                    (not (empty ?platform))
                    (is_in ?cargo ?platform)
                )
    )
    
    ; LOAD TRANSPORT
    (:action load_transport
        :parameters (?agent1 - agent
                     ?agent2 - agent
                     ?state - load_transport
                     ?truck - truck
                     ?crane - crane
                     ?dock - dock
                     ?platform - platform
                     ?cargo - cargo
                    )
        :precondition (and
                        (state ?agent1 ?state)
                        (state ?agent2 ?state)
                        (is_in ?agent1 ?crane)
                        (is_in ?crane ?dock)
                        (is_in ?dock ?platform)
                        (is_in ?cargo ?platform)
                        (is_in ?truck ?dock)
                        (is_in ?agent2 ?truck)
                        (not (empty ?platform))
                        (not (is_in ?cargo ?truck))
                        (empty ?truck)
                      )
        :effect (and 
                    (not (is_in ?cargo ?platform))
                    (is_in ?cargo ?truck)
                )
    )
    
    ; UNLOAD TRANSPORT
    (:action unload_transport
        :parameters (?agent1 - agent
                     ?agent2 - agent
                     ?state - unload_transport
                     ?truck - truck
                     ?crane - crane
                     ?dock - dock
                     ?platform - platform
                     ?cargo - cargo
        )
        :precondition (and 
                        (state ?agent1 ?state)
                        (state ?agent2 ?state)
                        (is_in ?agent1 ?crane)
                        (is_in ?agent2 ?truck)
                        (is_in ?truck ?dock)
                        (is_in ?crane ?dock)
                        (is_in ?platform ?dock)
                        (is_in ?cargo ?truck)
                        (not (is_in ?cargo ?platform))
                        (empty ?platform)
                        (not (empty ?truck))
        )
        :effect (and 
                    (not (is_in ?cargo ?truck))
                    (is_in ?cargo ?platform)
        )
    )
    
    ; DRIVE
    (:action drive_transport
        :parameters (?agent - agent
                     ?state - drive_transport
                     ?transport - transport
                     ?location1 - location
                     ?location2 - location
        )
        :precondition (and 
                        (state ?agent ?state)
                        (is_in ?agent ?transport)
                        (is_in ?transport ?location1)
                        (not (is_in ?transport ?location2))

                        (path ?location1 ?location2)
        )
        :effect (and 
                    (not (is_in ?transport ?location1))
                    (is_in ?transport ?location2)
        )
    )
)