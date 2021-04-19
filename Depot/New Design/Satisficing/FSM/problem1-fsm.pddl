(define (problem dock1) (:domain dock)
(:objects 
    dock1 - dock
    port1 - port
    distributor1 distributor2 - distributor
    ship1 - ship
    truck1 truck2 - truck
    crane1 - crane
    agent1 agent2 - agent
    container1 - container
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
    (in container1 ship1)
    (in cargo1 container1)
    (in cargo2 container1)
    (in cargo3 container1)

    (in truck1 port1)
    (in truck2 port1)
    (driver-available truck1)
    (passenger-available truck1)
    (driver-available truck2)
    (passenger-available truck2)
    
    (in crane1 dock1)
    (operator-available crane1)

    (in agent1 port1)
    (in agent2 port1)

    (idle agent1)
    (idle agent2)
)

(:goal (and
    (delivered cargo1 distributor1)
    (delivered cargo2 distributor1)
    (delivered cargo3 distributor2)
    (in container1 dock1)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
