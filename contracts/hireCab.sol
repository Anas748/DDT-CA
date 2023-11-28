// SPDX-License-Identifier: GPD-3.0
pragma solidity >0.4.0 <0.9.0;

contract TaxiRentalSystem {
    struct UserProfile {
        string name;
        uint8 rating;
    }


    mapping(address => UserProfile) public passengerProfiles;
    mapping(address => UserProfile) public driverProfiles;


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
   


    event FareOffered(uint256 fare);
    event FareAccepted();
    event DestinationArrived();
    event FarePaid();
    event PassengerRated(uint8 rating);
    




