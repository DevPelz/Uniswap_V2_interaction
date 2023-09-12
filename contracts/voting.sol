// SPDX-License-Identifier: MIT
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

    function registerVoter(address _voter) external {
        require(msg.sender == chairMan, "Only chairman can reggister voters");
        require(!voters[_voter].hasVoted, "The voter already voted");
        require(voters[voters].votingPower == 0, "voter has no votingPower");
        voters[_voter].votingPower = 1;
    }

    function createCandidate(string memory _name) external {
        _candidates.push(Candidates({name: _name, voteCount: 0}));
    }

    function vote(uint _candidatesIndex) external {
        Voter storage voter = voters[msg.sender];
        require(voter.votingPower > 0, "voter has no voting power");
        require(!voter.hasVoted, "Voter already voted");

        voter.votingPower = 0;
        voter.hasVoted = true;

        voter.votedFor = _candidatesIndex;
        _candidates[_candidatesIndex].voteCount += voter.votingPower;
    }

    function winningCandidate()
        public
        view
        returns (uint winningCandidateIndex)
    {
        uint winningVoteCount = 0;
        for (uint i = 0; i < _candidates.length; i++) {
            if (_candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = _candidates[i].voteCount;
                winningCandidateIndex = i;
            }
        }
    }

    function WinnersName()
        public
        view
        returns (string memory winningCandidateName_)
    {
        winningCandidateName_ = _candidates[winningCandidate()].name;
    }
}
