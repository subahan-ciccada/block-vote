// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract chain{
    address  council=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public candidate1;
    address public candidate2;
    enum state{start,stop}
    state s=state.stop;
    uint votecount1;
    uint votecount2;
    mapping(address=>bool) voted;

    modifier condition1(){
        require(msg.sender==council,"you are not the council");
        _;
    }
    modifier condition2(){
        require(s==state.start,"voting is not started yet");
        _;
    }
    constructor(address _candidate1,address _candidate2) {
        require(msg.sender==council);
     candidate1=_candidate1;
     candidate2=_candidate2;
    }
    function start() public condition1{
       s=state.start;
    }
    function stop() public condition1{
         s=state.stop;
    }

    struct voter{
        string name;
        uint age;
    }
    voter[ ] public voters;
    function voteforcandidate1(string memory _name,uint _age) public condition2{
       require(_age>=18,"you are not eligible for voting");
       require(voted[msg.sender]==false,"you cant vote again");
       voters.push(voter(_name,_age));
       voted[msg.sender]=true;
       votecount1++;
    }
    function voteforcandidate2(string memory _name,uint _age) public condition2{
       require(_age>=18,"you are not eligible for voting");
       require(voted[msg.sender]==false,"you cant vote again");
       voters.push(voter(_name,_age));
       voted[msg.sender]=true;
       votecount2++;
    }
    function result() public view condition1 returns(string memory){
        require(s==state.stop,"voting is not stopped");
       string memory str;
       if(votecount1>votecount2){
           str="candidate1 won the election";
       }
       else if(votecount1<votecount2){
           str="candidate2 won the election";
       }
       else{
           str="tie";
       }
       return str;
    }

}