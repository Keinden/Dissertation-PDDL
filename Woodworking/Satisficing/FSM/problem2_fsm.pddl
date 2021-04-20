(define (problem woodworking2) (:domain woodworking)
(:objects
    wd1 wd2 wd3 wd4 wd5 wd6 - wood
    toy1 toy2 - toy
    bkshelf1 bkshelf2 - bookshelf
    table1 table2 - table
    highspeed-saw1 - highspeed-saw
    planer1 - planer
    chisel1 - chisel
    bandsaw1 - bandsaw
    paint-brush1 - paint-brush
    red blue green - colour
    wproc1 - wood-processing
    cmake1 - product-making
    finish1 - finishing
    store1 - storage
    office1 - office
    agent1 agent2 agent3 - agent
)

(:init
    (in wd1 wproc1)
    (in wd2 wproc1)
    (in wd3 wproc1)
    (in wd4 wproc1)
    (in wd5 wproc1)
    (in wd6 wproc1)
    
    (raw wd1)
    (raw wd2)
    (raw wd3)
    (raw wd4)
    (raw wd5)
    (raw wd6)

    (in highspeed-saw1 wproc1)
    (in chisel1 cmake1)
    (in planer1 cmake1)
    (in bandsaw1 cmake1)
    (in paint-brush1 finish1)
    (in agent1 office1)
    (in agent2 office1)
    (in agent3 office1)

    (order toy1 red)
    (order toy2 blue)
    (order bkshelf1 blue)
    (order bkshelf2 green)
    (order table1 green)
    (order table2 red)

    (idle agent1)
    (idle agent2)
    (idle agent3)
)

(:goal (and
    (created-order toy1 wd1 red)
    (created-order toy2 wd2 blue)
    (created-order bkshelf1 wd3 blue)
    (created-order bkshelf2 wd4 green)
    (created-order table1 wd5 green)
    (created-order table2 wd6 red)
))

)
