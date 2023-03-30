pragma solidity ^0.8.19;

import "./zombiefactory.sol";

// インターフェイスを定義
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

// ZombieFactoryコントラクトを継承する
// ゾンビが他の人間達を捕食すると、そのDNAが人間DNAと結合して新しいゾンビを生み出す
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId];
      _targetDna = _targetDna % dnaModulus;
      uint newDna = (myZombie.dna + _targetDna) / 2;
      _createZombie("NoName", newDna);
  }
}