(define (problem dock2) (:domain temporal-dock)
(:objects 
    dock1 - dock
    port1 - port
    distributor1 distributor2 - distributor
    ship1 - ship
    truck1 truck2 - truck
    crane1 - crane
    agent1 agent2 - agent
    container1 container2 - container
    cargo1 cargo2 cargo3 - cargo
)

(:init
    (adjacent dock1 port1)
    (adjacent port1 dock1)
    (adjacent distributor1 port1)
    (adjacent port1 distributor1)
    (adjacent distributor2 port1)
    (adjacent port1 distributor2)
    
    (next ship1 dock1)
    (container-in container1 ship1)
    (container-in container2 ship1)
    (cargo-in cargo1 container1)
    (cargo-in cargo2 container1)
    (cargo-in cargo3 container2)

    (truck-in truck1 port1)
    (truck-in truck2 port1)
    (driver-available truck1)
    (passenger-available truck1)
    (truck-free truck1)
    (driver-available truck2)
    (passenger-available truck2)
    (truck-free truck1)
    
    (crane-in crane1 dock1)
    (operator-available crane1)
    (crane-free crane1)

    (agent-in agent1 port1)
    (agent-in agent2 port1)
)

(:goal (and
    (delivered cargo1 distributor1)
    (delivered cargo2 distributor1)
    (delivered cargo3 distributor2)
    (container-stored container1 dock1)
    (container-stored container2 dock1)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)