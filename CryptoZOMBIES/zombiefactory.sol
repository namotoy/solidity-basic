pragma solidity ^0.8.19;

contract ZombieFactory {
// ゾンビを作成するとイベントが発生する
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
        }
    
    Zombie[] public zombies;

//  ゾンビのオーナーをトラッキングするマッピングの設定
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

  //  ゾンビを配列に追加する
   function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
    // ゾンビのオーナーシップを関数を呼び出した人に割り当てる
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }
// ゾンビのハッシュ値を計算する
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
// ランダムにゾンビを生成する
    function createRandomZombie(string _name) public {
        // 最初のゾンビを作るときだけこの関数が呼び出す
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
