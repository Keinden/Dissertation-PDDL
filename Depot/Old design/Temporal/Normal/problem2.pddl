(define (problem dock1) (:domain dock)
(:objects 
    ; Map
    port1 - port
    dock1 - dock
    ship1 - ship
    distribution_centre1 - distribution_centre
    distributor1 distributor2 - distributor

    ; Vehicle
    truck1 - truck
    van1 van2 - van
    
    ; Agents
    agent1 agent2 agent3 - agent

    ; Machine
    crane1 - crane
    truck-crane1 truck-crane2 - truck_crane

    ; Containers & Cargo
    container1 - container
    cargo1 cargo2 cargo3 - cargo
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
    (next ship1 dock1)

    ; Agent Prep
    (agent_in agent1 port1)
    (agent_in agent2 port1)
    (agent_in agent3 distribution_centre1)

    ; Vehicle Prep
    (vehicle_in truck1 port1)
    (driver_available truck1)
    (passenger_available truck1)
    (vehicle_unloaded truck1)
    (vehicle_in van1 distribution_centre1)
    (vehicle_in van2 distribution_centre1)
    (driver_available van1)
    (driver_available van2)
    (vehicle_unloaded van1)
    (vehicle_unloaded van2)

    ; Machines Prep
    (machine_in crane1 dock1)
    (operator_available crane1)
    (machine_unloaded crane1)

    (machine_in truck-crane1 dock1)
    (operator_available truck-crane1)
    (machine_unloaded truck-crane1)
    (machine_in truck-crane2 distribution_centre1)
    (operator_available truck-crane2)
    (machine_unloaded truck-crane2)

    ; Container and Cargo Prep
    (container_stored container1 ship1)
    (cargo_stored cargo1 container1)
    (cargo_stored cargo2 container1)
    (cargo_stored cargo3 container1)
)

(:goal (and
    (delivered cargo1 distributor1)
    (delivered cargo2 distributor1)
    (delivered cargo3 distributor2)
    (vehicle_in truck1 port1)
    (vehicle_in van1 distribution_centre1)
    (vehicle_in van2 distribution_centre1)
))

)
