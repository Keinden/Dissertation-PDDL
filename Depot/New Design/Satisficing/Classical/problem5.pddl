(define (problem dock5) (:domain dock)
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
    (in container1 ship1)
    (in container2 ship1)
    (in container3 ship2)
    (in container4 ship2)
    (in cargo1 container1)
    (in cargo2 container1)
    (in cargo3 container2)
    (in cargo4 container2)
    (in cargo5 container2)
    (in cargo6 container3)
    (in cargo7 container3)
    (in cargo8 container3)
    (in cargo9 container4)
    (in cargo10 container4)
    (in cargo11 container4)
    (in cargo12 container4)

    (in truck1 port1)
    (in truck2 port1)
    (driver-available truck1)
    (passenger-available truck1)
    (driver-available truck2)
    (passenger-available truck2)
    
    (in crane1 dock1)
    (operator-available crane1)
    (in crane2 dock2)
    (operator-available crane2)

    (in agent1 port1)
    (in agent2 port1)
    (in agent3 port1)

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
    (in container1 dock1)
    (in container2 dock1)
    (in container3 dock2)
    (in container4 dock2)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
