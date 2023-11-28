// SPDX-License-Identifier: GPD-3.0
pragma solidity >0.4.0 <0.9.0;

contract TaxiRentalSystem {
    struct UserProfile {
        string name;
        uint8 rating;
    }

     // Maps Ethereum addresses to user profiles
    mapping(address => UserProfile) public passengerProfiles;
    mapping(address => UserProfile) public driverProfiles;

    // State variables to track the current state of the taxi ride
    address public passenger;
    address public driver;
    string public pickupLocation;
    string public dropoffLocation;
    uint256 public distanceKM;
    uint256 public fare;
    bool public fareOffered;
    bool public fareAccepted;
    bool public destinationArrived;
    bool public farePaid;
    uint8 public passengerRating;
   

    // Events to signal important steps in the ride process
    event FareOffered(uint256 fare);
    event FareAccepted();
    event DestinationArrived();
    event FarePaid();
    event PassengerRated(uint8 rating);




