(define (problem dockyard_fsm_problem) (:domain dockyard)
    (:objects
        agent1 agent2 - agent
        truck1 - truck
        ship1 - ship
        crane1 crane2 - crane
        platform1 platform2 platform3 platform4 - platform
        dock1 dock2 - dock
        bridge1 - bridge
        cargo1 cargo2 - cargo

        ; States
        idle - idle
        get_cargo - get_cargo
        load_transport - load_transport
        drive_transport - drive_transport
        unload_transport - unload_transport
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
        (is_in crane1 dock1)
        (is_in crane2 dock2)
        (is_in platform1 dock1)
        (is_in platform2 dock1)
        (is_in platform3 dock2)
        (is_in platform4 dock2)
        (is_in ship1 dock1)
        (is_in cargo1 ship1)
        (is_in cargo2 ship1)
        (is_in truck1 dock2)
        (is_in agent1 dock2)
        (is_in agent2 dock2)

        ;Empty
        (empty platform1)
        (empty platform2)
        (empty platform3)
        (empty platform4)
        (empty truck1)

    )

    (:goal (and
        ;(is_in cargo1 platform3)
        ;(is_in cargo2 platform4)

        (is_in truck1 dock1)
        ;(is_in agent1 dock1)
        ;(is_in agent2 dock1)
        )
    
    )
)
