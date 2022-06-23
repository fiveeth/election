// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Election {

    mapping(address=>bool) public voters;

    // 统计有几个候选人
    uint public candidatesCount;

    struct Candidate {
        uint id;
        string name;  //候选人的名字
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;

    event votedEvent (uint indexed _candidateId);

    constructor() {
        addCandidate("Lee");
        addCandidate("Mike");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount ++;

        emit votedEvent(_candidateId);
    }
}