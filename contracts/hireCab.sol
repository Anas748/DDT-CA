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


    // Constructor initializes the default values for state variables
    constructor() {
        passenger = msg.sender;
        driver = address(0); // Initially, no driver is assigned
        pickupLocation = "";
        dropoffLocation = "";
        distanceKM = 0;
        fare = 0;
        fareOffered = false;
        fareAccepted = false;
        destinationArrived = false;
        farePaid = false;
        passengerRating = 0;
    }

      // Modifier: Ensures that only the passenger can call the function
    modifier onlyPassenger() {
        require(msg.sender == passenger, "Only the passenger can call this function");
        _;
    }

    // Modifier: Ensures that only the driver can call the function
    modifier onlyDriver() {
        require(msg.sender == driver, "Only the driver can call this function");
        _;
    }

    // Modifier: Ensures that fare has not been offered yet
    modifier notYetOffered() {
        require(!fareOffered, "Fare has already been offered");
        _;
    }

    // Modifier: Ensures that fare has not been accepted yet
    modifier notYetAccepted() {
        require(!fareAccepted, "Fare has already been accepted");
        _;
    }

    // Modifier: Ensures that destination has not arrived yet
    modifier notYetArrived() {
        require(!destinationArrived, "Destination has already arrived");
        _;
    }

    // Modifier: Ensures that fare has not been paid yet
    modifier notYetPaid() {
        require(!farePaid, "Fare has already been paid");
        _;
    }

    // Modifier: Ensures that the passenger can rate only after the destination is arrived and fare is paid
    modifier canRate() {
        require(destinationArrived && farePaid, "You can only rate after the destination is arrived and fare is paid");
        require(passengerRating == 0, "You have already rated the driver");
        _;
    }

