(define (problem dock1) (:domain dock_fsm)
(:objects 
    port1 - port
    dock1 - dock
    ship1 - ship
    distribution_centre1 - distribution_centre
    distributor1 distributor2 - distributor
    container1 - container
    cargo1 cargo2 cargo3 cargo4 cargo5 - cargo
    truck-crane1 truck-crane2 - truck_crane
    crane1 - crane
    agent1 agent2 - agent
    truck1 - truck
    van1 van2 - van
)

(:init
    ; Map Layout
    (adjacent port1 dock1)
    (adjacent dock1 port1)
    (adjacent port1 distribution_centre1)
    (adjacent distribution_centre1 port1)
    (adjacent distributor1 distribution_centre1)
    (adjacent distribution_centre1 distributor1)
    (adjacent distributor2 distribution_centre1)
    (adjacent distribution_centre1 distributor2)
    
    ; Ship prep
    (adjacent ship1 dock1)
    (in container1 ship1)
    (in cargo1 container1)
    (in cargo2 container1)
    (in cargo3 container1)
    (in cargo4 container1)
    (in cargo5 container1)

    ; Port prep
    (in crane1 dock1)
    (unloaded crane1)
    (operator_available crane1)

    ; Agent Prep
    (in agent1 port1)
    (in agent2 port1)

    ; Vehicle Locations
    (in truck1 port1)
    (in truck-crane1 dock1)
    (in truck-crane2 distribution_centre1)
    (in van1 distribution_centre1)
    (in van2 distribution_centre1)

    ; Vehicle Prep
    (driver_available truck1)
    (driver_available van1)
    (driver_available van2)
    (operator_available truck-crane1)
    (operator_available truck-crane2)
    (passenger_available truck1)
    (unloaded truck-crane1)
    (unloaded truck-crane2)
    (unloaded truck1)
    (unloaded van1)
    (unloaded van2)

    ; Initial States
    (idle agent1)
    (idle agent2)
)

(:goal (and
    (in cargo1 distributor1)
    (in cargo2 distributor1)
    (in cargo3 distributor2)
    (in cargo4 distributor2)
    (in cargo5 distributor2)
    (in truck1 port1)
    (in van1 distribution_centre1)
    (in van2 distribution_centre1)
    (in agent1 port1)
    (in agent2 port1)
))
)
