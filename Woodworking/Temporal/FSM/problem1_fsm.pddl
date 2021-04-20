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
    cmake1 - product-making
    finish1 - finishing
    store1 - storage
    office1 - office
    agent1 agent2 - agent
)

(:init
    (wood-in wd1 wproc1)
    (wood-in wd2 wproc1)
    (wood-in wd3 wproc1)
    
    (raw wd1)
    (raw wd2)
    (raw wd3)

    (tool-in highspeed-saw1 wproc1)
    (tool-in chisel1 cmake1)
    (tool-in planer1 cmake1)
    (tool-in bandsaw1 cmake1)
    (tool-in paint-brush1 finish1)
    (agent-in agent1 office1)
    (agent-in agent2 office1)

    (tool-free highspeed-saw1)
    (tool-free chisel1)
    (tool-free planer1)
    (tool-free bandsaw1)
    (tool-free paint-brush1)

    (order toy1 red)
    (order bkshelf1 blue)
    (order table1 green)
    
    (idle agent1)
    (idle agent2)
)

(:goal (and
    (created-order toy1 wd1 red)
    (created-order bkshelf1 wd2 blue)
    (created-order table1 wd3 green)
))

)
