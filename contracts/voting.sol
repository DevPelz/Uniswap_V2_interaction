// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

contract voting {
    struct Voter {
        uint votingPower;
        uint votedFor;
        bool hasVoted;
    }

    struct Candidates {
        string name;
        uint voteCount;
    }

    address public chairMan;

    mapping(address => Voter) public voters;

    Candidates[] public _candidates;

    constructor() {
        chairMan = msg.sender;
        voters[chairMan].votingPower = 1;
    }
}
