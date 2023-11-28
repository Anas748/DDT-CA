// SPDX-License-Identifier: MIT
pragma solidity >0.4.0 <0.8.0;


import "./taxiSystem.sol";

contract Passenger {

   // Passenger's name
   string public name;

   // Passenger's Ethereum address
   address public passengerAddress;

   // Number of rides requested by the passenger
   uint256 public requestedRides;

   // Driver contract instance
   Driver public driverContract;

   // Function to register a passenger
   function registerPassenger(string memory _name, address _driverContractAddress) public {
       name = _name;
       passengerAddress = msg.sender;
       driverContract = Driver(_driverContractAddress);
   }

   // Function to request a ride
   function requestRide(uint256 _noOfRides) public {
       requestedRides = _noOfRides;
   }

   // Function to check if a driver is available
   function checkDriverAvailability() public view {
       if (driverContract.isAvailable()) {
           // Driver is available
       } else {
           // Driver is not available
       }
   }
}