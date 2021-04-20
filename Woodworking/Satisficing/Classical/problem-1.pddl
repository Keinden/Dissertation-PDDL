(define (problem woodworking1) (:domain woodworking)
(:objects
    wd1 wd2 wd3 - wood
    toy1 - toy
    bkshelf1 - bookshelf
    table1 - table
    highspeed-saw1 - highspeed-saw
    planer1 - planer
    chisel1 - chisel
    bandsaw1 - bandsaw
    paint-brush1 - paint-brush
    red blue green - colour
    wproc1 - wood-processing
    pmake1 - product-making
    finish1 - finishing
    store1 - storage
    office1 - office
    agent1 agent2 - agent
)

(:init
    (in wd1 wproc1)
    (in wd2 wproc1)
    (in wd3 wproc1)
    
    (raw wd1)
    (raw wd2)
    (raw wd3)

    (in highspeed-saw1 wproc1)
    (in chisel1 pmake1)
    (in planer1 pmake1)
    (in bandsaw1 pmake1)
    (in paint-brush1 finish1)
    (in agent1 office1)
    (in agent2 office1)

    (order toy1 red)
    (order bkshelf1 blue)
    (order table1 green)
)

(:goal (and
    (created-order toy1 wd1 red)
    (created-order bkshelf1 wd2 blue)
    (created-order table1 wd3 green)
))

)
