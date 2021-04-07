(define (domain debug_dockyard)
    (:requirements :strips :typing :conditional-effects :negative-preconditions :equality :universal-preconditions)
    (:types
        location
        bridge dock - location

        agent
        
        transport
        truck - transport

        state
        idle drive_transport - state
    )

    (:predicates (is_in ?x ?y)
                 (state_of_agent ?agent - agent ?state - state)
                 (path ?x - location ?y - location)

                 ; CHECKS
                 (empty ?x)
    )

    (:action change_into_state
        :parameters (?agent - agent
                     ?state1 - idle
                     ?state2 - state
                    )
        :precondition (and
                        (state_of_agent ?agent ?state1)
                        (not (state_of_agent ?agent ?state2))
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
    
    (:action into_transport
        :parameters (?agent - agent
                     ?state - drive_transport
                     ?truck - transport
                     ?dock - dock
                    )
        :precondition (and
                        (state ?agent ?state)
                        (not (is_in ?agent ?truck))
                        (is_in ?agent ?dock)
                        (is_in ?truck ?dock)
        )
        :effect (and
                    (is_in ?agent ?truck)
                    (not (is_in ?agent ?dock))
        )
    )
    
    (:action exit_transport
        :parameters (?agent - agent
                     ?state - drive_transport
                     ?truck - transport
                     ?dock - dock
                    )
        :precondition (and
                        (state ?agent ?state)
                        (is_in ?agent ?truck)
                        (not (is_in ?agent ?dock))
                        (is_in ?truck ?dock)
        )
        :effect (and
                    (not (is_in ?agent ?truck))
                    (is_in ?agent ?dock)
        )
    )
    
)