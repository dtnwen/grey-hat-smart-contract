// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract GreyHat {
	constructor() {}

	// protocols => exploiter
	struct GoodHacker {
		address exploiter;
		uint256 amount;
		bool returned;
	}
	mapping(address => bool) public implemented;
	mapping (address => GoodHacker) track;
	uint256 bountyPortion = 15;

	function implement() public {
		require(implemented[msg.sender] == false, "Already implemented");
		implemented[msg.sender] = true;
	}

	function depositExploitedFund(address protocol) public payable {
		require(
			implemented[protocol] == true,
			"Protocol hasn't implement contract"
		);
		uint256 bounty = bountyCalculate(msg.value);

		_returnProtocol(protocol, msg.value, bounty);
		_rewardBounty(bounty);
		
		track[protocol] = GoodHacker(msg.sender, msg.value, true);
	}

	function bountyCalculate(uint256 fund) public view returns (uint256) {
		return (fund * bountyPortion) / 100;
	}

	function _rewardBounty(uint256 fund) private {
		(bool s, ) = msg.sender.call{ value: fund }("");
		require(s, "Reward bounty failed");
	}

	function _returnProtocol(
		address protocol,
		uint256 fund,
		uint256 bounty
	) private {
		uint256 fundReturn = fund - bounty;
		(bool s, ) = payable(protocol).call{ value: fundReturn }("");
		require(s, "Return protocol failed");
	}

	// function bargain() returns () {}
	// I'm not sure this function should be implemented, yet

	function invite(address recipient, bytes calldata message) public payable {
		(bool s, ) = payable(recipient).call{ value: msg.value }(message);
		require(s, "Send messages failed");
	}
}
