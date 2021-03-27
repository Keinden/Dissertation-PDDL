(define (problem debug_dockyard_fsm_problem) (:domain debug_dockyard)
    (:objects
        agent1 agent2 - agent
        truck1 - truck
        dock1 dock2 - dock
        bridge1 - bridge

        ; States
        idle - idle
        drive_transport - state
    )

    (:init
        ;States
        (state agent1 idle)
        (state agent2 idle)

        ;Paths
        (path dock1 bridge1)
        (path bridge1 dock1)
        (path dock2 bridge1)
        (path bridge1 dock2)

        ;Locations
        (is_in truck1 dock2)
        (is_in agent1 dock2)
        (is_in agent2 dock2)

        ;Empty
        (empty truck1)
    )

    
    (:goal (and
            (state agent1 idle)
            (state agent2 idle)
        )
    
    )
)
