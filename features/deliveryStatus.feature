Feature: Plan routes within vehicle capacity and publish current versions
  As a route coordinator
  I want routes planned within vehicle capacity and changes clearly versioned
  So that loads fit the vehicle and drivers follow the current route

  # Assumption: capacity is expressed in pallet spaces for this example only.
  # The scenario does not state how capacity is measured.

  Rule: Planned goods must not exceed the capacity of the assigned vehicle

    Scenario Outline: Capacity check at and beyond the vehicle limit (boundary)
      Given van "KY-VAN-04" has a capacity of 10 pallet spaces
      And route "Tralee to Dingle" has consignments totalling <load> pallet spaces
      When the coordinator assigns van "KY-VAN-04" to the route
      Then the result is "<result>"

      Examples:
        | load | result                              |
        | 8    | accepted                            |
        | 10   | accepted                            |
        | 11   | capacity conflict reported to coordinator |

  Rule: Drivers must be able to identify the current route version

    Scenario: Republished route replaces the earlier version (exception)
      Given route "Tralee to Dingle" version 1 has been published
      And driver "Tomas Murphy" has been given version 1
      When the coordinator changes the order of stops and republishes the route
      Then the route is recorded as version 2
      And driver "Tomas Murphy" is shown version 2 as the current version
      And version 1 is shown as no longer current
