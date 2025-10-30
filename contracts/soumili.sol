// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title SimpleAuction - A minimal single-click deployable auction contract
/// @notice The contract owner can start and end an auction. Highest bidder wins.
contract SimpleAuction {
    struct Bid {
        address bidder;
        uint256 amount;
    }

    Bid[] public bids;
    address public owner;
    address public winner;
    uint256 public highestBid;
    bool public ended;

    /// @notice Set the deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    /// @notice Place a bid (must send ETH)
    function placeBid() external payable {
        require(!ended, "Auction has ended");
        require(msg.value > 0, "Bid must be > 0");

        bids.push(Bid(msg.sender, msg.value));

        if (msg.value > highestBid) {
            highestBid = msg.value;
            winner = msg.sender;
        }
    }

    /// @notice End the auction (only owner)
    function endAuction() external {
        require(msg.sender == owner, "Only owner can end");
        require(!ended, "Already ended");
        ended = true;

        // Transfer the highest bid to the owner
        payable(owner).transfer(highestBid);
    }

    /// @notice Get total number of bids
    function getBidsCount() external view returns (uint256) {
        return bids.length;
    }
}
