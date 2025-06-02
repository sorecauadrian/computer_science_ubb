### PassengerRegistry.sol

```solidity
pragma solidity ^0.8.0;

contract PassengerRegistry {
    address public admin;

    struct Passenger {
        string name;
        bool isRegistered;
    }

    mapping(address => Passenger) public passengers;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can do this");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registerPassenger(address _passenger, string memory _name) public onlyAdmin {
        passengers[_passenger] = Passenger(_name, true);
    }

    function isRegisteredPassenger(address _addr) public view returns (bool) {
        return passengers[_addr].isRegistered;
    }

    function getPassengerName(address _addr) public view returns (string memory) {
        return passengers[_addr].name;
    }
}
```

### BaggageTracking.sol

```solidity
pragma solidity ^0.8.0;

import "./PassengerRegistry.sol";

contract BaggageTracking {
    address public admin;
    PassengerRegistry public passengerRegistry;

    enum Status { CheckedIn, InTransit, Arrived, Claimed }

    struct Baggage {
        uint id;
        address owner;
        string description;
        Status status;
    }

    mapping(uint => Baggage) public baggages;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin allowed");
        _;
    }

    modifier onlyOwner(uint _baggageId) {
        require(baggages[_baggageId].owner == msg.sender, "Not your baggage");
        _;
    }

    constructor(address _passengerRegistry) {
        admin = msg.sender;
        passengerRegistry = PassengerRegistry(_passengerRegistry);
    }

    function registerBaggage(uint _id, address _passenger, string memory _desc) public onlyAdmin {
        require(passengerRegistry.isRegisteredPassenger(_passenger), "Passenger not registered");

        baggages[_id] = Baggage({
            id: _id,
            owner: _passenger,
            description: _desc,
            status: Status.CheckedIn
        });
    }

    function updateStatus(uint _id, Status _newStatus) public onlyAdmin {
        baggages[_id].status = _newStatus;
    }

    function confirmClaim(uint _id) public onlyOwner(_id) {
        baggages[_id].status = Status.Claimed;
    }

    function getStatus(uint _id) public view returns (Status) {
        return baggages[_id].status;
    }

    function getBaggageOwner(uint _id) public view returns (address) {
        return baggages[_id].owner;
    }

    function getDescription(uint _id) public view returns (string memory) {
        return baggages[_id].description;
    }
}
```

### Notes

- **PassengerRegistry**: Maintains a list of verified passengers registered by airport staff. Each passenger is associated with a wallet address and name.

- **BaggageTracking**: Allows the airport to assign baggage to registered passengers and track the status of each baggage item throughout its journey.

Only authorized airport staff (admin) can register passengers and baggage or update status. Passengers can view their baggage status and confirm claim ownership.
