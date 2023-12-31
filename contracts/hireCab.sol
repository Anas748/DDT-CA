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
        // Function: Register a passenger profile
    function registerPassengerProfile(string memory _name) public {
        passengerProfiles[msg.sender].name = _name;
    }

    // Function: Register a driver profile
    function registerDriverProfile(string memory _name) public {
        driverProfiles[msg.sender].name = _name;
    }
      // Function: Assign a driver to the passenger
    function Driver(address _driver) public notYetOffered {
        driver = _driver;
    }
       // Specify pickup and drop-off locations 
    function specifyPickupAndDropoff(string memory _pickupLocation, string memory _dropoffLocation) public onlyPassenger notYetOffered {
        pickupLocation = _pickupLocation;
        dropoffLocation = _dropoffLocation;
    }
     // Offer fare from driver to passenger 
    function offerFare(uint256 _distanceKM, uint256 _fare) public onlyDriver notYetOffered {
        distanceKM = _distanceKM;
        fare = _fare;
        fareOffered = true;
        emit FareOffered(_fare);
    }

    // Accept the offered fare from passenger 
    function acceptFare() public onlyPassenger notYetAccepted {
        require(fareOffered, "Fare has not been offered");
        fareAccepted = true;
        emit FareAccepted();
    }
         // Confirm destination arrival
    function confirmDestinationArrival() public onlyDriver notYetArrived {
        destinationArrived = true;
        emit DestinationArrived();
    }


    // Pay the fare to the driver
    function payFare() public payable onlyPassenger notYetPaid {
    require(fareAccepted, "Fare has not been accepted");
    require(destinationArrived, "Destination has not yet arrived");
    require(msg.value >= fare, "Insufficient Ether sent to pay the fare");
    payable(driver).transfer(msg.value);
    farePaid = true;
    emit FarePaid();
    }

    // Rate the driver
  
function rateDriver(uint8 _rating) public onlyPassenger canRate {
    require(_rating >= 1 && _rating <= 5, "Rating must be between 1 and 5");

    // Update passengerRating in the contract state
    passengerRating = _rating;
    emit PassengerRated(_rating);

    // Update driver's rating in the user profile
    driverProfiles[driver].rating = _rating;
}


     // Get passenger profile
    function getPassengerProfile() public view returns (string memory name, uint8 rating) {
        UserProfile storage profile = passengerProfiles[msg.sender];
        return (profile.name, profile.rating);
    }


    // Get driver profile
    function getDriverProfile() public view returns (string memory name, uint8 rating) {
        UserProfile storage profile = driverProfiles[msg.sender];
        return (profile.name, profile.rating);
    }
}
