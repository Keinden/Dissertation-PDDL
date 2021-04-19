(define (problem sandwich_problem) (:domain sandwich_example)
(:objects 
    bread1 bread2 - bread
    ham1 - ham
    cheese1 - cheese
    plate1 - plate
)

(:init
    (on-table plate1)
    (on-table bread1)
    (on-table bread2)
    (on-table ham1)
    (on-table cheese1)
    (not-holding)
    (top plate1)
)

(:goal (and
    (on bread1 plate1)
    (on ham1 bread1)
    (on cheese1 ham1)
    (on bread2 cheese1)
))
)
