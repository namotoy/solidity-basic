pragma solidity ^0.4.19;

import "./zombiefactory.sol";
// ZombieFactoryコントラクトを継承する
// ゾンビが他の人間達を捕食すると、そのDNAが人間DNAと結合して新しいゾンビを生み出す
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId];
  }
}