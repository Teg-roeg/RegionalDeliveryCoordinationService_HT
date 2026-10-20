Feature: Inform customers of delivery status changes
  As a customer
  I want to know whether my delivery is delayed, transferred or returning
  So that I can plan around the change

  Rule: Customers are told when a delivery is delayed

    Scenario: Late collection delays a customer's delivery (exception)
      Given customer "Dingle Harbour Cafe" has delivery "D-310" scheduled for 14:00
      And the collection for "D-310" from producer "Kerry Valley Dairy" is running late
      When the coordinator records "D-310" as delayed
      Then "Dingle Harbour Cafe" is notified that delivery "D-310" is delayed
      And the producer "Kerry Valley Dairy" is also notified of the delay
