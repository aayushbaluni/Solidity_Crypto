pragma solidity >=0.7.0 < 0.9.0;

contract MyFirstCoin{
    address  admin;
    mapping(address =>uint) balance;
   
   //Succesfully sent!
    event Sent(address from,address to,uint amount);
    constructor(){
        admin=msg.sender;
    }
    //send from admin
    function SendfromAdmin(address to,uint amount) public {
        require(admin==msg.sender);
        balance[to] +=amount;
    }

    //if error occured
    error InsuficientBalace(address from,address to,uint amount);
       
    //p2p
    function Send(address to,uint amount) public  {
        if(balance[msg.sender]<amount) revert InsuficientBalace(msg.sender,to,amount);
        balance[msg.sender] -=amount;
        balance[to] +=amount; 
        emit Sent(msg.sender,to,amount);
    }
    // Function to redeem
    function Redeem(uint amount) public payable returns(bool sucess) {
        require(balance[msg.sender]>=amount);
        payable(msg.sender).transfer(amount);
        balance[msg.sender] -=amount;
        return true;
        
    }
    
}
