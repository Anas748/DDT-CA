// SPDX-License-Identifier: MIT
pragma solidity >0.4.0 <0.8.0;

contract Driver {

   // Driver's name
   string public name;

   // Driver's Ethereum address
   address public driverAddress;

   // Availability status of the driver
   bool public isAvailable;

   // Function to register a driver
   function registerDriver(string memory _name) public {
       name = _name;
       driverAddress = msg.sender;
       isAvailable = true;
   }

   // Function to update availability status
   function updateAvailability(bool _availability) public {
       isAvailable = _availability;
   }
}