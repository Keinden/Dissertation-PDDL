(define (problem dock1) (:domain dock)
(:objects 
    dock1 - dock
    distribution_centre1 - distribution_centre
    distributor1 distributor2 - distributor
    container1 - container
    cargo1 cargo2 cargo3 cargo4 - cargo
    truck-crane1 truck-crane2 - truck_crane
    agent1 agent2 - agent
    truck1 - truck
    van1 van2 - van
)

(:init
    ; Map Layout
    (adjacent dock1 distribution_centre1)
    (adjacent distribution_centre1 dock1)
    (adjacent distributor1 distribution_centre1)
    (adjacent distribution_centre1 distributor1)
    (adjacent distributor2 distribution_centre1)
    (adjacent distribution_centre1 distributor2)
    
    ; Ship prep
    (in container1 dock1)
    (in cargo1 container1)
    (in cargo2 container1)
    (in cargo3 container1)
    (in cargo4 container1)

    ; Agent Prep
    (in agent1 dock1)
    (in agent2 dock1)

    ; Vehicle Locations
    (in truck1 dock1)
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
)

(:goal (and
    (in truck1 dock1)
    (in container1 dock1)
    (in cargo1 distributor1)
    (in cargo2 distributor1)
    (in cargo3 distributor2)
    (in cargo4 distributor2)
    (in agent1 dock1)
    (in agent2 dock1)
))
)
