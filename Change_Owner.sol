pragma solidity >=0.7.0 <0.9.0;

contract Restricted {
    address owner = msg.sender;
    uint256 public time = block.timestamp;

    modifier OnlyOwner(address _address) {
        require(_address == msg.sender, "User Not Authorised!");
        _;
    }
    modifier OnlyAfter(uint256 _time) {
        require(block.timestamp == _time, "Too Early");
        _;
    }

    modifier cost(uint256 amount) {
        require(msg.value >= amount, "Insufficient Amount");
        _;
    }

    function SetOwner(address _account) public {
        owner = _account;
    }

    function ChangeAddress(address _account) public OnlyOwner(owner) {
        owner = _account;
    }

    function DelOwner() public OnlyOwner(owner) OnlyAfter(time + 5 seconds) {
        delete owner;
    }

    function forceChange(address _address) public payable cost(20000 ether) {
        owner = _address;
    }
}
