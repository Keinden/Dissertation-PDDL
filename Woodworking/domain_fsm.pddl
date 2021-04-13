(define (domain woodworking_fsm)

(:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions)

(:types
    wood
    highspeed-saw planer chisel bandsaw drill paint-brush - tool
    chair
    colour
    wood-processing component-making assembly finishing storage office - location
    agent
)

(:predicates
    (in ?x ?y)
    
    ;Wood types
    (raw ?wood - wood)
    (large ?wood - wood)
    (medium ?wood - wood)
    (small ?wood - wood)

    ;Wood components
    (legs ?wood - wood)
    (seat ?wood - wood)
    (back ?wood - wood)
    (arm ?wood - wood)

    ;Chair componets
    (order ?chair - chair)
    (assembled ?chair - chair)
    (chair-legs ?chair - chair ?legs - wood)
    (chair-seat ?chair - chair ?seat - wood)
    (chair-back ?chair - chair ?back - wood)
    (chair-arm ?chair - chair ?arm - wood)

    (finished ?chair - chair ?clr - colour)

    (idle ?agt)
    (wood-process ?agt)
    (component-process ?agt)
    (assembly-process ?agt)
    (finish-process ?agt)
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
        (or
            (wood-process ?agt)
            (component-process ?agt)
        )
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
        (wood-process ?agt)
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
        (wood-process ?agt)
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
        (wood-process ?agt)
    )
    :effect (and 
        (not (raw ?wood))
        (small ?wood)
    )
)

(:action make-legs
    :parameters (?agt - agent ?wood - wood ?chs - chisel ?loc - component-making)
    :precondition (and
        (in ?agt ?loc)
        (in ?wood ?loc)
        (in ?chs ?loc)
        (medium ?wood)
        (component-process ?agt)
    )
    :effect (and 
        (not (medium ?wood))
        (legs ?wood)
    )
)

(:action make-seat
    :parameters (?agt - agent ?wood - wood ?pln - planer ?loc - component-making)
    :precondition (and 
        (in ?agt ?loc)
        (in ?wood ?loc)
        (in ?pln ?loc)
        (medium ?wood)
        (component-process ?agt)
    )
    :effect (and 
        (not (large ?wood))
        (seat ?wood)
    )
)

(:action make-back
    :parameters (?agt - agent ?wood - wood ?pln - planer ?loc - component-making)
    :precondition (and 
        (in ?agt ?loc)
        (in ?wood ?loc)
        (in ?pln ?loc)
        (large ?wood)
        (component-process ?agt)
    )
    :effect (and 
        (not (large ?wood))
        (back ?wood)
    )
)

(:action make-arm
    :parameters (?agt - agent ?wood - wood ?pln - planer ?bnd - bandsaw ?chs - chisel ?loc - component-making)
    :precondition (and
        (in ?agt ?loc)
        (in ?wood ?loc)
        (in ?pln ?loc)
        (in ?bnd ?loc)
        (in ?chs ?loc)
        (small ?wood)
        (component-process ?agt)
    )
    :effect (and
        (not (small ?wood))
        (arm ?wood)
    )
)

(:action assemble-chair
    :parameters (?agt - agent ?wood1 - wood ?wood2 - wood ?wood3 - wood ?wood4 - wood ?drl - drill ?loc - assembly ?chr - chair)
    :precondition (and 
        (in ?agt ?loc)
        (in ?wood1 ?loc)
        (in ?wood2 ?loc)
        (in ?wood3 ?loc)
        (in ?wood4 ?loc)
        (in ?drl ?loc)
        (arm ?wood1)
        (legs ?wood2)
        (seat ?wood3)
        (back ?wood4)
        (order ?chr)
        (assembly-process ?agt)
    )
    :effect (and
        (not (order ?chr))
        (assembled ?chr)
        (in ?chr ?loc)
        (chair-arm ?chr ?wood1)
        (chair-legs ?chr ?wood2)
        (chair-seat ?chr ?wood3)
        (chair-back ?chr ?wood4)
        (not (in ?wood1 ?loc))
        (not (in ?wood2 ?loc))
        (not (in ?wood3 ?loc))
        (not (in ?wood4 ?loc))
        (in ?wood1 ?chr)
        (in ?wood2 ?chr)
        (in ?wood3 ?chr)
        (in ?wood4 ?chr)
    )
)

(:action move-chair
    :parameters (?agt - agent ?chr - chair ?loc1 - location ?loc2 - location)
    :precondition (and
        (in ?agt ?loc1)
        (in ?chr ?loc1)
        (assembled ?chr)
        (or
            (assembly-process ?agt)
            (finish-process ?agt)
        )
    )
    :effect (and
        (not (in ?chr ?loc1))
        (in ?chr ?loc2)
    )
)

(:action finish_chair
    :parameters (?agt - agent ?chr - chair ?ptbh - paint-brush ?clr - colour ?loc - finishing)
    :precondition (and
        (in ?agt ?loc)
        (in ?chr ?loc)
        (in ?ptbh ?loc)
        (assembled ?chr)
        (finish-process ?agt)
    )
    :effect (and
        (not (assembled ?chr))
        (finished ?chr ?clr)
    )
)

(:action change_out_state
    :parameters (?agt - agent)
    :precondition (or
        (assembly-process ?agt)
        (component-process ?agt)
        (wood-process ?agt)
        (finish-process ?agt)
    )
    :effect (and
        (idle ?agt)
        (not (assembly-process ?agt))
        (not (component-process ?agt))
        (not (wood-process ?agt))
        (not (finish-process ?agt))
    )
)

(:action change_into_assembly
    :parameters (?agt - agent)
    :precondition (and
        (idle ?agt)
    )
    :effect (and
        (not (idle ?agt))
        (assembly-process ?agt)
    )
)

(:action change_into_component
    :parameters (?agt - agent)
    :precondition (and
        (idle ?agt)
    )
    :effect (and
        (not (idle ?agt))
        (component-process ?agt)
    )
)

(:action change_into_wood
    :parameters (?agt - agent)
    :precondition (and
        (idle ?agt)
    )
    :effect (and
        (not (idle ?agt))
        (wood-process ?agt)
    )
)

(:action change_into_finish
    :parameters (?agt - agent)
    :precondition (and
        (idle ?agt)
    )
    :effect (and
        (not (idle ?agt))
        (finish-process ?agt)
    )
)

)