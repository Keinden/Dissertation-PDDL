(define (domain woodworking)

(:requirements :strips :typing :conditional-effects :negative-preconditions :equality)

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
    (in ?x ?y)
    
    ;Wood types
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
)

(:action change-position
    :parameters (?agt - agent ?loc1 - location ?loc2 - location)
    :precondition (and 
        (in ?agt ?loc1)
    )
    :effect (and 
        (not (in ?agt ?loc1))
        (in ?agt ?loc2)
    )
)

(:action move_wood
    :parameters (?agt - agent ?wood - wood ?loc1 - location ?loc2 - location)
    :precondition (and
        (in ?agt ?loc1)
        (in ?wood ?loc1)
    )
    :effect (and
        (not (in ?wood ?loc1))
        (in ?wood ?loc2)
    )
)

(:action make-large-wood
    :parameters (?wood - wood ?saw - highspeed-saw ?agt - agent ?loc - wood-processing)
    :precondition (and 
        (in ?saw ?loc)
        (in ?agt ?loc)
        (in ?wood ?loc)
        (raw ?wood)
    )
    :effect (and 
        (not (raw ?wood))
        (large ?wood)
    )
)

(:action make-medium-wood
    :parameters (?wood - wood ?saw - highspeed-saw ?agt - agent ?loc - wood-processing)
    :precondition (and 
        (in ?saw ?loc)
        (in ?agt ?loc)
        (in ?wood ?loc)
        (raw ?wood)
    )
    :effect (and 
        (not (raw ?wood))
        (medium ?wood)
    )
)

(:action make-small-wood
    :parameters (?wood - wood ?saw - highspeed-saw ?agt - agent ?loc - wood-processing)
    :precondition (and 
        (in ?saw ?loc)
        (in ?agt ?loc)
        (in ?wood ?loc)
        (raw ?wood)
    )
    :effect (and 
        (not (raw ?wood))
        (small ?wood)
    )
)

(:action make-toy
    :parameters (?agt - agent ?wood - wood ?chs - chisel ?loc - product-making)
    :precondition (and
        (in ?agt ?loc)
        (in ?wood ?loc)
        (in ?chs ?loc)
        (small ?wood)
        (not (toy-object ?wood))
    )
    :effect (and 
        (not (medium ?wood))
        (toy-object ?wood)
    )
)

(:action make-bookshelf
    :parameters (?agt - agent ?wood - wood ?pln - planer ?loc - product-making)
    :precondition (and 
        (in ?agt ?loc)
        (in ?wood ?loc)
        (in ?pln ?loc)
        (medium ?wood)
        (not (bookshelf-object ?wood))
    )
    :effect (and 
        (not (medium ?wood))
        (bookshelf-object ?wood)
    )
)

(:action make-table
    :parameters (?agt - agent ?wood - wood ?pln - planer ?bsaw - bandsaw ?loc - product-making)
    :precondition (and 
        (in ?agt ?loc)
        (in ?wood ?loc)
        (in ?pln ?loc)
        (in ?bsaw ?loc)
        (large ?wood)
        (not (table-object ?wood))
    )
    :effect (and 
        (not (large ?wood))
        (table-object ?wood)
    )
)

(:action finish-toy
    :parameters (?agt - agent ?wood - wood ?pdt - toy ?clr - colour ?ptbh - paint-brush ?loc - finishing)
    :precondition (and 
        (in ?agt ?loc)
        (in ?ptbh ?loc)
        (in ?wood ?loc)
        (order ?pdt ?clr)
        (toy-object ?wood)
        (not (painted-object ?pdt ?clr))
    )
    :effect (and 
        (painted-object ?pdt ?clr)
        (created-order ?pdt ?wood ?clr)
        (not (in ?wood ?loc))
        (in ?wood ?pdt)
        (in ?pdt ?loc)
    )
)

(:action finish-table
    :parameters (?agt - agent ?wood - wood ?pdt - table ?clr - colour ?ptbh - paint-brush ?loc - finishing)
    :precondition (and 
        (in ?agt ?loc)
        (in ?ptbh ?loc)
        (in ?wood ?loc)
        (order ?pdt ?clr)
        (table-object ?wood)
        (not (painted-object ?pdt ?clr))
    )
    :effect (and 
        (painted-object ?pdt ?clr)
        (created-order ?pdt ?wood ?clr)
        (not (in ?wood ?loc))
        (in ?wood ?pdt)
        (in ?pdt ?loc)
    )
)

(:action finish-bookshelf
    :parameters (?agt - agent ?wood - wood ?pdt - bookshelf ?clr - colour ?ptbh - paint-brush ?loc - finishing)
    :precondition (and 
        (in ?agt ?loc)
        (in ?ptbh ?loc)
        (in ?wood ?loc)
        (order ?pdt ?clr)
        (bookshelf-object ?wood)
        (not (painted-object ?pdt ?clr))
    )
    :effect (and 
        (painted-object ?pdt ?clr)
        (created-order ?pdt ?wood ?clr)
        (not (in ?wood ?loc))
        (in ?wood ?pdt)
        (in ?pdt ?loc)
    )
)

(:action move-product
    :parameters (?agt - agent ?pdt - product ?loc1 - location ?loc2 - location)
    :precondition (and 
        (in ?agt ?loc1)
        (in ?pdt ?loc1)
    )
    :effect (and 
        (not (in ?pdt ?loc1))
        (in ?pdt ?loc2)
    )
)

)