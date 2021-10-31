
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "GameObject.sol";
// This is class that describes you smart contract.
contract BasicStation is GameObject {
    
    GameObject [] arrayWarUnit;
    mapping (GameObject => uint) mappingWarUnit;

    function setHP (uint initialHP) private {
        tvm.accept();
        HP = initialHP;
    }

    function addWarUnit (GameObject addressWarUnit) external  checkOwnerAndAccept {
        arrayWarUnit.push(addressWarUnit);
        uint key = arrayWarUnit.length;
        mappingWarUnit [addressWarUnit] = key;
    }

    function deleteWarUnit (GameObject addressWarUnit) external checkOwnerAndAccept {
        uint deleteKey = mappingWarUnit [addressWarUnit];
        delete arrayWarUnit[deleteKey];
    }

    function deathBasicStation () external  checkOwnerAndAccept {
        death();
        for (uint i; i <= arrayWarUnit.length - 1; i++) {
            arrayWarUnit[i].deathBecauseOfBase ();
        }
    }
}