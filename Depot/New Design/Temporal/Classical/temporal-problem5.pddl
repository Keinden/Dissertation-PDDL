(define (problem dock5) (:domain temporal-dock)
(:objects 
    dock1 dock2 - dock
    port1 - port
    distributor1 distributor2 - distributor
    ship1 ship2 - ship
    truck1 truck2 - truck
    crane1 crane2 - crane
    agent1 agent2 agent3 - agent
    container1 container2 container3 container4 - container
    cargo1 cargo2 cargo3 cargo4 cargo5 cargo6 cargo7 cargo8 cargo9 cargo10 cargo11 cargo12 - cargo
)

(:init
    (adjacent dock1 port1)
    (adjacent port1 dock1)
    (adjacent dock2 port1)
    (adjacent port1 dock2)
    (adjacent dock1 dock2)
    (adjacent dock2 dock1)
    (adjacent distributor1 port1)
    (adjacent port1 distributor1)
    (adjacent distributor2 port1)
    (adjacent port1 distributor2)
    
    (next ship1 dock1)
    (next ship2 dock2)
    (container-in container1 ship1)
    (container-in container2 ship1)
    (container-in container3 ship2)
    (container-in container4 ship2)
    (cargo-in cargo1 container1)
    (cargo-in cargo2 container1)
    (cargo-in cargo3 container2)
    (cargo-in cargo4 container2)
    (cargo-in cargo5 container2)
    (cargo-in cargo6 container3)
    (cargo-in cargo7 container3)
    (cargo-in cargo8 container3)
    (cargo-in cargo9 container4)
    (cargo-in cargo10 container4)
    (cargo-in cargo11 container4)
    (cargo-in cargo12 container4)

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
    (crane-in crane2 dock2)
    (operator-available crane2)
    (crane-free crane2)

    (agent-in agent1 port1)
    (agent-in agent2 port1)
    (agent-in agent3 port1)
    
)

(:goal (and
    (delivered cargo1 distributor1)
    (delivered cargo2 distributor1)
    (delivered cargo3 distributor2)
    (delivered cargo4 distributor2)
    (delivered cargo5 distributor2)
    (delivered cargo6 distributor1)
    (delivered cargo7 distributor1)
    (delivered cargo8 distributor1)
    (delivered cargo9 distributor2)
    (delivered cargo10 distributor2)
    (delivered cargo11 distributor2)
    (delivered cargo12 distributor2)
    (container-stored container1 dock1)
    (container-stored container2 dock1)
    (container-stored container3 dock2)
    (container-stored container4 dock2)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)