(define (domain durative_dock)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types
    location
    dock distribution_centre distributor - location

    vehicle
    work_vehicle distribution_vehicle - vehicle
    truck - work_vehicle
    van - distribution_vehicle

    machine
    truck_crane - machine

    agent
    container
    cargo
)


(:predicates
    ; General
    (in ?x ?y)
    (adjacent ?loc1 - location ?loc2 - location)

    (loaded ?wveh - work_vehicle ?cont - container)
    (loaded ?dveh - distribution_vehicle ?crgo - cargo)
    (unloaded ?vehicle)
)


(:functions
    ()
)

;define actions here

)