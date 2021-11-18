
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */

pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "ShoppingListStructures.sol";

// This is class that describes you smart contract.
contract ShoppingListSmartContract {

    uint256 m_ownerPubkey;
    uint32 m_id;
    mapping(uint32 => Purchase)  purchasesMapping;

    constructor(uint pubkey) public {
        require(pubkey != 0, 120);
        tvm.accept();
        m_ownerPubkey = pubkey;
    }

    modifier onlyOwner() {
        require(msg.pubkey() == m_ownerPubkey, 101);
        _;
    }

    function getStat() public view returns (SummaryOfShopping summary) {
        uint32 paidCount;
        uint32 unpaidCount;
        uint64 sum;

        for((, Purchase purchase) : purchasesMapping) {
            if  (purchase.isBought) {
                paidCount ++;
                sum += purchase.priceForPurchase;
            } else {
                unpaidCount ++;
            }
        }
        summary = SummaryOfShopping (paidCount, unpaidCount, sum);
    }

    function addPurchase (string name, uint32 number) public onlyOwner {
        tvm.accept();
        Purchase [] purchaseArray;
        m_id++; 
        purchasesMapping[m_id] = Purchase(m_id, name, number, now, false, 0);

    }

    function deletePurchase (uint32 id) public onlyOwner {
        tvm.accept();
        require (purchasesMapping.exists(id),102);
        delete purchasesMapping[id];
    }

    function buy (uint32 id, uint64 priceForPurchase) public onlyOwner {
        tvm.accept();
        require (purchasesMapping.exists(id),102);
        purchasesMapping[id].priceForPurchase = priceForPurchase;
        purchasesMapping[id].isBought = true;
    }

    function getPurchase () public view returns (Purchase [] purchaseArray) {
        for (uint32 i; i <= m_id; i++){
            purchaseArray.push(purchasesMapping[i]);
        }
    }
    
}
