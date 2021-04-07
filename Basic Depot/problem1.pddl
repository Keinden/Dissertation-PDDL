(define (problem dock1) (:domain dock)
(:objects 
    dock1 dock2 - dock
    truck1 - truck
    ship1 - ship
    crane1 - crane
    truck-crane1 truck-crane2 truck-crane3 - truck-crane
    agent1 agent2 - agent
    container1 - container
    cargo1 cargo2 cargo3 cargo4 cargo5 - cargo
    distribution_centre1 - distribution_centre
)

(:init
    (adjacent dock1 dock2)
    (adjacent dock2 dock1)
    (adjacent dock1 ship1)
    (adjacent dock1 distribution_centre1)
    (adjacent dock2 distribution_centre1)
    (adjacent distribution_centre1 dock1)
    (adjacent distribution_centre1 dock2)
    (in agent1 dock2)
    (in agent2 dock2)
    (in truck-crane1 dock1)
    (in truck-crane2 dock2)
    (in truck-crane3 distribution_centre1)
    (in truck1 dock2)
    (in container1 ship1)
    (in crane1 dock1)
    
    (unloaded truck-crane1)
    (unloaded truck-crane2)
    (unloaded truck-crane3)
    (unloaded truck1)
    (available truck-crane1)
    (available truck-crane2)
    (available truck-crane3)
    (available truck1)
    (available crane1)
    
    (stored container1 ship1)
    (in cargo1 container1)
    (in cargo2 container1)
    (in cargo3 container1)
    (in cargo4 container1)
    (in cargo5 container1)
)

(:goal (and
    (in cargo1 distribution_centre1)
    (in cargo2 distribution_centre1)
    (in cargo3 distribution_centre1)
    (in cargo4 distribution_centre1)
    (in cargo5 distribution_centre1)

    ; (loaded truck1 container1)
    ; (in truck1 distribution_centre1)
    ; (in agent1 distribution_centre1)
    ; (in agent2 truck-crane3)

    ; (stored container1 distribution_centre1)
))



)
