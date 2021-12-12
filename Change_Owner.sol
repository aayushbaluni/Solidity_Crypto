pragma solidity >=0.7.0 <0.9.0;

contract Restricted{
address owner= msg.sender;

modifier OnlyOwner( address _address){
    require(_address==msg.sender,'User Not Authorised!');
    _;
}
function SetOwner(address _account) public {
    owner=_account;
}
function ChangeAddress(address _account) public OnlyOwner(owner){
    owner=_account;
} 
}