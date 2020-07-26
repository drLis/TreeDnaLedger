pragma solidity >=0.6.0 <0.7.0;


contract TreeDnaLedger
{
	event DnaHashed(string treeName, bytes32 hashedDna, uint treeId);

	event DnaConfirmation(uint indexed treeId, address indexed oracle, bytes32 indexed hashedDna, bool isConfirmed);

	function addNewTree(string memory treeName, bytes32 hashedDna) external
	{
		treeNames[numberOfTrees] = treeName;
		hashedTreeDna[numberOfTrees] = hashedDna;

		emit DnaHashed(treeName, hashedDna, numberOfTrees);

		numberOfTrees++;
	}

	function tryToConfirmTree(uint treeId, bytes32 hashedDna) external returns (bool)
	{
		bool result = hashedTreeDna[treeId] == hashedDna;

		emit DnaConfirmation(treeId, msg.sender, hashedDna, result);

		return result;
	}

	function computeHashOfDna(string memory dna) public pure returns (bytes32)
	{
		return keccak256(abi.encode(dna));
	}

	mapping (uint => string) public treeNames;

	mapping (uint => bytes32) public hashedTreeDna;

	uint public numberOfTrees = 1;
}