(define (domain woodworking)

(:requirements :strips :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types
    wood
    tool
    highspeed-saw planer chisel bandsaw paint-brush - tool
    product
    toy bookshelf table - product
    colour
    location
    wood-processing product-making finishing storage office - location
    agent
)

(:predicates 
    (agent-in ?agt - agent ?loc - location)
    (wood-in ?wood - wood ?loc - location)
    (tool-in ?tool - tool ?loc - location)
    (product-in ?pdt - product ?loc - location)
    
    (raw ?wood - wood)
    (large ?wood - wood)
    (medium ?wood - wood)
    (small ?wood - wood)

    (order ?prod - product ?clr - colour)
    (created-order ?prod - product ?wood - wood ?clr - colour)
    (table-object ?wood - wood)
    (bookshelf-object ?wood - wood)
    (toy-object ?wood - wood)
    (painted-object ?prod - product ?clr - colour)

    (tool-free ?tool - tool)
    (idle ?agt - agent)
    (wood-processing-state ?agt - agent)
    (product-making-state ?agt - agent)
    (finishing-state ?agt - agent)
)

(:durative-action move-location
    :parameters (?agt - agent ?loc1 - location ?loc2 - location)
    :duration (= ?duration 2)
    :condition (and 
        (at start (and 
            (agent-in ?agt ?loc1)
        ))
    )
    :effect (and 
        (at start (and 
            (not (agent-in ?agt ?loc1))
        ))
        (at end (and 
            (agent-in ?agt ?loc2)
        ))
    )
)

(:durative-action move-wood
    :parameters (?agt - agent ?wood - wood ?loc1 - location ?loc2 - location)
    :duration (= ?duration 2)
    :condition (and 
        (at start (and 
            (wood-in ?wood ?loc1)
        ))
        (over all (and 
            (agent-in ?agt ?loc1)
        ))
    )
    :effect (and 
        (at start (and 
            (not (wood-in ?wood ?loc1))
        ))
        (at end (and 
            (wood-in ?wood ?loc2)
        ))
    )
)

(:durative-action make-large-wood
    :parameters (?wood - wood ?saw - highspeed-saw ?agt - agent ?loc - wood-processing)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (tool-free ?saw)
            (raw ?wood)
        ))
        (over all (and 
            (agent-in ?agt ?loc)
            (tool-in ?saw ?loc)
            (wood-in ?wood ?loc)
            (wood-processing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (tool-free ?saw))
            (not (raw ?wood))
        ))
        (at end (and 
            (large ?wood)
            (tool-free ?saw)
        ))
    )
)

(:durative-action make-medium-wood
    :parameters (?wood - wood ?saw - highspeed-saw ?agt - agent ?loc - wood-processing)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (tool-free ?saw)
            (raw ?wood)
        ))
        (over all (and 
            (agent-in ?agt ?loc)
            (tool-in ?saw ?loc)
            (wood-in ?wood ?loc)
            (wood-processing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (tool-free ?saw))
            (not (raw ?wood))
        ))
        (at end (and 
            (medium ?wood)
            (tool-free ?saw)
        ))
    )
)

(:durative-action make-small-wood
    :parameters (?wood - wood ?saw - highspeed-saw ?agt - agent ?loc - wood-processing)
    :duration (= ?duration 8)
    :condition (and 
        (at start (and 
            (tool-free ?saw)
            (raw ?wood)
        ))
        (over all (and 
            (agent-in ?agt ?loc)
            (tool-in ?saw ?loc)
            (wood-in ?wood ?loc)
            (wood-processing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (tool-free ?saw))
            (not (raw ?wood))
        ))
        (at end (and 
            (small ?wood)
            (tool-free ?saw)
        ))
    )
)

(:durative-action make-toy
    :parameters (?agt - agent ?wood - wood ?chs - chisel ?loc - product-making)
    :duration (= ?duration 15)
    :condition (and 
        (at start (and 
            (small ?wood)
            (tool-free ?chs)
        ))
        (over all (and 
            (agent-in ?agt ?loc)
            (tool-in ?chs ?loc)
            (wood-in ?wood ?loc)
            (product-making-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (small ?wood))
            (not (tool-free ?chs))
        ))
        (at end (and 
            (toy-object ?wood)
            (tool-free ?chs)
        ))
    )
)

(:durative-action make-bookshelf
    :parameters (?agt - agent ?wood - wood ?pln - planer ?loc - product-making)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (medium ?wood)
            (tool-free ?pln)
        ))
        (over all (and 
            (agent-in ?agt ?loc)
            (tool-in ?pln ?loc)
            (wood-in ?wood ?loc)
            (product-making-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (medium ?wood))
            (not (tool-free ?pln))
        ))
        (at end (and 
            (bookshelf-object ?wood)
            (tool-free ?pln)
        ))
    )
)

(:durative-action make-table
    :parameters (?agt - agent ?wood - wood ?pln - planer ?bsaw - bandsaw ?loc - product-making)
    :duration (= ?duration 20)
    :condition (and 
        (at start (and 
            (large ?wood)
            (tool-free ?pln)
            (tool-free ?bsaw)
        ))
        (over all (and 
            (agent-in ?agt ?loc)
            (tool-in ?pln ?loc)
            (tool-in ?bsaw ?loc)
            (wood-in ?wood ?loc)
            (product-making-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (large ?wood))
            (not (tool-free ?pln))
            (not (tool-free ?bsaw))
        ))
        (at end (and 
            (table-object ?wood)
            (tool-free ?pln)
            (tool-free ?bsaw)
        ))
    )
)

(:durative-action finish-toy
    :parameters (?agt - agent ?wood - wood ?pdt - toy ?clr - colour ?ptbh - paint-brush ?loc - finishing)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (toy-object ?wood)
            (tool-free ?ptbh)
            (wood-in ?wood ?loc)
        ))
        (over all (and 
            (order ?pdt ?clr)
            (agent-in ?agt ?loc)
            (tool-in ?ptbh ?loc)
            (finishing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (wood-in ?wood ?loc))
            (not (tool-free ?ptbh))
        ))
        (at end (and 
            (painted-object ?pdt ?clr)
            (created-order ?pdt ?wood ?clr)
            (product-in ?pdt ?loc)
            (tool-free ?ptbh)
        ))
    )
)

(:durative-action finish-table
    :parameters (?agt - agent ?wood - wood ?pdt - table ?clr - colour ?ptbh - paint-brush ?loc - finishing)
    :duration (= ?duration 10)
    :condition (and 
        (at start (and 
            (table-object ?wood)
            (tool-free ?ptbh)
            (wood-in ?wood ?loc)
        ))
        (over all (and 
            (order ?pdt ?clr)
            (agent-in ?agt ?loc)
            (tool-in ?ptbh ?loc)
            (finishing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (wood-in ?wood ?loc))
            (not (tool-free ?ptbh))
        ))
        (at end (and 
            (painted-object ?pdt ?clr)
            (created-order ?pdt ?wood ?clr)
            (product-in ?pdt ?loc)
            (tool-free ?ptbh)
        ))
    )
)

(:durative-action finish-bookshelf
    :parameters (?agt - agent ?wood - wood ?pdt - bookshelf ?clr - colour ?ptbh - paint-brush ?loc - finishing)
    :duration (= ?duration 5)
    :condition (and 
        (at start (and 
            (bookshelf-object ?wood)
            (tool-free ?ptbh)
            (wood-in ?wood ?loc)
        ))
        (over all (and 
            (order ?pdt ?clr)
            (agent-in ?agt ?loc)
            (tool-in ?ptbh ?loc)
            (finishing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (wood-in ?wood ?loc))
            (not (tool-free ?ptbh))
        ))
        (at end (and 
            (painted-object ?pdt ?clr)
            (created-order ?pdt ?wood ?clr)
            (product-in ?pdt ?loc)
            (tool-free ?ptbh)
        ))
    )
)

(:durative-action idle-state-to-wood-processing-state
    :parameters (?agt - agent)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (idle ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (idle ?agt))
        ))
        (at end (and 
            (wood-processing-state ?agt)
        ))
    )
)

(:durative-action wood-processing-state-to-idle-state
    :parameters (?agt - agent)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (wood-processing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (wood-processing-state ?agt))
        ))
        (at end (and 
            (idle ?agt)
        ))
    )
)


(:durative-action idle-state-to-product-making-state
    :parameters (?agt - agent)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (idle ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (idle ?agt))
        ))
        (at end (and 
            (product-making-state ?agt)
        ))
    )
)

(:durative-action product-making-state-to-idle-state
    :parameters (?agt - agent)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (product-making-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (product-making-state ?agt))
        ))
        (at end (and 
            (idle ?agt)
        ))
    )
)

(:durative-action idle-state-to-finishing-state
    :parameters (?agt - agent)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (idle ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (idle ?agt))
        ))
        (at end (and 
            (finishing-state ?agt)
        ))
    )
)

(:durative-action finishing-state-to-idle-state
    :parameters (?agt - agent)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (finishing-state ?agt)
        ))
    )
    :effect (and 
        (at start (and 
            (not (finishing-state ?agt))
        ))
        (at end (and 
            (idle ?agt)
        ))
    )
)
)
