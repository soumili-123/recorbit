<img width="1519" height="824" alt="Screenshot 2025-10-29 152456" src="https://github.com/user-attachments/assets/60ea2488-3b01-47df-8da3-9456d9f8bbad" />

# 🪙 SimpleAuction Smart Contract

A minimal, easy-to-deploy **Ethereum-compatible auction contract** that lets users place bids in ETH (or CELO, on compatible networks). The highest bidder wins when the auction ends — simple as that.

---

## 📖 Project Description

**SimpleAuction** is a beginner-friendly smart contract built in Solidity that demonstrates the core mechanics of a basic auction system on the blockchain.  
It allows:
- Multiple users to place bids with ETH (or the native currency of the network).
- The contract owner to start and end an auction.
- Automatic tracking of the highest bidder and bid amount.
- Secure transfer of funds to the auction owner once the auction ends.

This project is perfect for developers learning about Solidity, smart contract logic, and blockchain-based auction mechanisms.

---

## ⚙️ What It Does

1. **Deploy the Contract**  
   The deployer automatically becomes the owner of the auction.

2. **Accept Bids**  
   Users can place bids by sending ETH to the contract via the `placeBid()` function.

3. **Determine the Winner**  
   The contract continuously updates the highest bid and bidder in real-time.

4. **End the Auction**  
   Only the owner can end the auction. Once ended:
   - No more bids are accepted.
   - The highest bid amount is transferred to the owner.
   - The top bidder becomes the winner.

---

## ✨ Features

- 🧑‍💼 **Owner-Controlled:** Only the owner can end the auction.  
- 💰 **Secure Fund Handling:** Transfers the highest bid safely to the owner.  
- 📈 **Real-Time Highest Bid Tracking:** Updates the winner automatically.  
- 🪶 **Lightweight & Gas-Efficient:** Clean and minimal code, great for demos or education.  
- 🌐 **EVM Compatible:** Works on Ethereum, Celo, Polygon, and other EVM-based networks.

---

## 🔗 Deployed Smart Contract

**Network:** Celo Sepolia Testnet  
**Explorer Link:**  
👉 [View Contract on Blockscout](https://celo-sepolia.blockscout.com/tx/0xc22a5bb42723440983ba38e545c1fd4adb00c7cb6e695cabc3af41318b7eab45)

---

## 🧩 Smart Contract Code

```solidity
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
<img width="1519" height="824" alt="Screenshot 2025-10-29 152456" src="https://github.com/user-attachments/assets/e3842670-7469-495b-9594-4af100f34ed1" />
