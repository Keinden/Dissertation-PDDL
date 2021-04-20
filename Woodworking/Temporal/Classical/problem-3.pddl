(define (problem woodworking3) (:domain woodworking)
(:objects
    wd1 wd2 wd3 wd4 wd5 wd6 wd7 wd8 wd9 wd10 - wood
    toy1 toy2 toy3 toy4 toy5 - toy
    bkshelf1 bkshelf2 bkshelf3 - bookshelf
    table1 table2 - table
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
    agent1 agent2 agent3 agent4 - agent
)

(:init
    (wood-in wd1 wproc1)
    (wood-in wd2 wproc1)
    (wood-in wd3 wproc1)
    (wood-in wd4 wproc1)
    (wood-in wd5 wproc1)
    (wood-in wd6 wproc1)
    (wood-in wd7 wproc1)
    (wood-in wd8 wproc1)
    (wood-in wd9 wproc1)
    (wood-in wd10 wproc1)
    
    (raw wd1)
    (raw wd2)
    (raw wd3)
    (raw wd4)
    (raw wd5)
    (raw wd6)
    (raw wd7)
    (raw wd8)
    (raw wd9)
    (raw wd10)

    (tool-in highspeed-saw1 wproc1)
    (tool-in chisel1 pmake1)
    (tool-in planer1 pmake1)
    (tool-in bandsaw1 pmake1)
    (tool-in paint-brush1 finish1)
    (agent-in agent1 office1)
    (agent-in agent2 office1)

    (tool-free highspeed-saw1)
    (tool-free chisel1)
    (tool-free planer1)
    (tool-free bandsaw1)
    (tool-free paint-brush1)

    (order toy1 red)
    (order toy2 blue)
    (order toy3 red)
    (order toy4 red)
    (order toy5 red)
    (order bkshelf1 blue)
    (order bkshelf2 green)
    (order bkshelf3 blue)
    (order table1 green)
    (order table2 red)
)

(:goal (and
    (created-order toy1 wd1 red)
    (created-order toy2 wd2 blue)
    (created-order toy3 wd3 red)
    (created-order toy4 wd4 red)
    (created-order toy5 wd5 red)
    (created-order bkshelf1 wd6 blue)
    (created-order bkshelf2 wd7 green)
    (created-order bkshelf3 wd8 blue)
    (created-order table1 wd9 green)
    (created-order table2 wd10 red)
))

)
