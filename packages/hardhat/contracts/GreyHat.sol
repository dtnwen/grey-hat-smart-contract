// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract GreyHat {
	event ReturnFund(
		address indexed exploiter,
		address indexed victim,
		uint256 amount,
		uint256 bounty
	);

	mapping(address => bool) public implemented;
	uint256 bountyPortion = 15;

	function implement() public {
		require(implemented[msg.sender] == false, "Already implemented");
		implemented[msg.sender] = true;
	}

	function depositExploitedFund(address victim) public payable {
		require(
			implemented[victim] == true,
			"Victim hasn't implement contract"
		);
		require(msg.value > 0, "Can't deposit 0");
		uint256 bounty = bountyCalculate(msg.value);

		_returnVictim(victim, msg.value, bounty);
		_rewardBounty(bounty);

		emit ReturnFund(msg.sender, victim, msg.value, bounty);
	}

	function bountyCalculate(uint256 fund) public view returns (uint256) {
		return (fund * bountyPortion) / 100;
	}

	function _rewardBounty(uint256 fund) private {
		(bool s, ) = msg.sender.call{ value: fund }("");
		require(s, "Reward bounty failed");
	}

	function _returnVictim(
		address victim,
		uint256 fund,
		uint256 bounty
	) private {
		uint256 fundReturn = fund - bounty;
		(bool s, ) = payable(victim).call{ value: fundReturn }("");
		require(s, "Return victim failed");
	}

	// function bargain() returns () {}
	// I'm not sure this function should be implemented, yet
}
