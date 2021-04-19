(define (problem dock6) (:domain dock)
(:objects 
    dock1 dock2 - dock
    port1 port2 - port
    distributor1 distributor2 - distributor
    ship1 ship2 ship3 ship4 - ship
    truck1 truck2 truck3 truck4 - truck
    crane1 crane2 - crane
    agent1 agent2 agent3 agent4 - agent
    container1 container2 container3 container4 container5 container6 container7 container8 - container
    cargo1 cargo2 cargo3 cargo4 cargo5 cargo6 cargo7 cargo8 cargo9 cargo10 cargo11 cargo12 cargo13 cargo14 cargo15 cargo16 - cargo
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
    (adjacent distributor1 port2)
    (adjacent port2 distributor1)
    (adjacent distributor2 port2)
    (adjacent port2 distributor2)
    
    (next ship1 dock1)
    (next ship2 dock1)
    (next ship3 dock2)
    (next ship4 dock2)
    (in container1 ship1)
    (in container2 ship1)
    (in container3 ship2)
    (in container4 ship2)
    (in container5 ship3)
    (in container6 ship3)
    (in container7 ship4)
    (in container8 ship4)
    (in cargo1 container1)
    (in cargo2 container1)
    (in cargo3 container2)
    (in cargo4 container2)
    (in cargo5 container3)
    (in cargo6 container3)
    (in cargo7 container4)
    (in cargo8 container4)
    (in cargo9 container5)
    (in cargo10 container5)
    (in cargo11 container6)
    (in cargo12 container6)
    (in cargo13 container7)
    (in cargo14 container7)
    (in cargo15 container8)
    (in cargo16 container8)

    (in truck1 port1)
    (in truck2 port1)
    (in truck3 port1)
    (in truck4 port1)
    (driver-available truck1)
    (passenger-available truck1)
    (driver-available truck2)
    (passenger-available truck2)
    (driver-available truck3)
    (passenger-available truck3)
    (driver-available truck4)
    (passenger-available truck4)
    
    (in crane1 dock1)
    (operator-available crane1)
    (in crane2 dock2)
    (operator-available crane2)

    (in agent1 port1)
    (in agent2 port1)
    (in agent3 port1)
    (in agent4 port1)

    (idle agent1)
    (idle agent2)
    (idle agent3)
    (idle agent4)
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
    (delivered cargo13 distributor1)
    (delivered cargo14 distributor2)
    (delivered cargo15 distributor1)
    (delivered cargo16 distributor2)
    (in container1 dock1)
    (in container2 dock1)
    (in container3 dock1)
    (in container4 dock1)
    (in container5 dock2)
    (in container6 dock2)
    (in container7 dock2)
    (in container8 dock2)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
