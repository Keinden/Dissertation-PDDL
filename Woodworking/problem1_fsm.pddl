(define (problem woodworking-1) (:domain woodworking)
(:objects
    wd1 wd2 wd3 wd4 wd5 wd6 wd7 wd8 wd9 wd10 wd11 wd12 wd13 wd14 wd15 wd16 - wood
    chr1 chr2 chr3 - chair
    highspeed-saw1 - highspeed-saw
    planer1 - planer
    chisel1 - chisel
    bandsaw1 - bandsaw
    drill1 - drill
    paint-brush1 - paint-brush
    red blue green - colour
    wproc1 - wood-processing
    cmake1 - component-making
    assem1 - assembly
    finish1 - finishing
    store1 - storage
    office1 - office
    agent1 agent2 - agent
)

(:init
    (in wd1 wproc1)
    (in wd2 wproc1)
    (in wd3 wproc1)
    (in wd4 wproc1)
    (in wd5 wproc1)
    (in wd6 wproc1)
    (in wd7 wproc1)
    (in wd8 wproc1)
    (in wd9 wproc1)
    (in wd10 wproc1)
    (in wd11 wproc1)
    (in wd12 wproc1)
    (in wd13 wproc1)
    (in wd14 wproc1)
    (in wd15 wproc1)
    (in wd16 wproc1)
    
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
    (raw wd11)
    (raw wd12)
    (raw wd13)
    (raw wd14)
    (raw wd15)
    (raw wd16)

    (in highspeed-saw1 wproc1)
    (in chisel1 cmake1)
    (in planer1 cmake1)
    (in bandsaw1 cmake1)
    (in paint-brush1 finish1)
    (in drill1 assem1)
    

    (order chr1)
    (order chr2)
    (order chr3)

    (in agent1 office1)
    (in agent2 office1)
    (idle agent1)
    (idle agent2)
)

(:goal (and
    (finished chr1 red)
    (finished chr2 blue)
    (finished chr3 green)
    (in chr1 store1)
    (in chr2 store1)
    (in chr3 store1)
))

)
