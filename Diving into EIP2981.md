# Diving into EIP-2981

Despite the popularity of NFT with many of them traded many times across different platforms, there has not been a standard way to easily and consistently transfer the royalty information to ensure artists and creators receive their set royalty across diferrent on-chain and off-chain marketplaces.

![image](https://user-images.githubusercontent.com/48362877/196007439-850c1527-4c23-4a07-92aa-f8ae279f1e98.png)

Royalty is an important topic as it is one of the largest source of continuous support for the artists and creators. NFT Royalty has been a hot topic lately across Twitter as collection such as DeGod experimenting with 0% royalty and exchange implements optional royalty. This fires an issue of royalty honor. 

![image](https://user-images.githubusercontent.com/48362877/196007510-69754078-652f-41e9-878d-310108d5835d.png)

![image](https://user-images.githubusercontent.com/48362877/196007781-edd17148-7e40-4232-afba-5fcafff6af22.png)

![image](https://user-images.githubusercontent.com/48362877/196007700-1df1bb6c-fdc4-4468-85e2-02856dc13109.png)

In the heat of this issue, now is a good time to have a deeper understanding of EIP-2981. 

In short, EIP-2981 is a way to record an NFT royalty on-chain.

So **how has royalty been kept track of?**

Well, there are various royalty systems depends on the NFT marketplace created for the purpose of enforcing and tracking royalty. Platforms such as Manifold, Rarible, and Zora offer royalty options, but others don’t. therefore, users need to be aware of the terms when they resells their NFTs outside of the original platform. 

On the other hand, resellers have also bypassed the attached royalty through off-chain marketplaces. 

With the current situation, there is clearly a problem that needs to be addressed.

And the inefficient way of transfering royalty information has led to the proposal of EIP-2981.

## 👑 What is EIP-2981? 

"A standardized way to retrieve royalty payment information for non-fungible tokens (NFTs) to enable universal support for royalty payments across all NFT marketplaces and ecosystem participants."<sup>1</sup>
     
## 🏗️ What can be built with it

EIP-2981 is a universal royalty standard and is not limited to the implementation of ERC-721 and ERC-1155 alone. As long as a contract is compatible with the constraints of EIP-2981, it can use this standard to retrieve royalty payment information.  

## 🧑‍🍳 A Demo

View the Github repo with the source code [here](https://github.com/UsuaOSilver/crystalize.dev-research/tree/main/contracts).

### 📍 Let’s start with **IERC2981.sol**

![image](https://user-images.githubusercontent.com/48362877/196006210-a6925a92-5b01-441d-ae58-df30e4ea47f3.png)


### 📍 Now we put it into implementation with **ERC2981.sol**

![image](https://user-images.githubusercontent.com/48362877/196006164-692c8cf9-f8a4-4824-b287-e0e592aa130e.png)

     
**The most important funtion of EIP-2981 is `royaltyInfo()`.** This function calculates the amount of royalty, maintains and returns the royalty information of all token ids of the contract.

     function royaltyInfo(uint256 _tokenId, uint256 _salePrice) 
         public 
         view 
         virtual 
         override 
         returns (address, uint256) 
     {
         RoyaltyInfo memory royalty = _tokenToRoyaltyInfo;

         if (royalty.receiver == address(0)) {
             royalty = _RoyaltyInfo;
         }

         uint256 royaltyAmount = (_salePrice * royalty.amount) / 10000;

         return (royalty.receiver, royaltyAmount);
     }
     
This function gives the contract the flexibility to modifide any information related to the NFT in the future. It can be excluded from the source code if the information should be fixed through time. 
     
     function _setRoyalty(address _receiver, uint96 _amount) internal virtual {
         require(_amount <= 10000, "ERC2981: royalty fee exceeds salePrice");
         require(receiver != address(0), "ERC2981: invalid receiver address");

         _RoyaltyInfo = RoyaltyInfo(_receiver, _amount);
     }

     
### 📍 Now let see EIP-2981 in action supporting an ERC721 contract.

![image](https://user-images.githubusercontent.com/48362877/196006101-612aa307-6181-4f43-9619-ab34d55bfb8d.png)

The `setRoyalty()` function will be used by the marketplaces to enforce royalty on this entire contract. 
   
        function setRoyalty(address receiver, uint96 amount)
            external
            /*onlyOwner*/
        {
            _setRoyalty(receiver, amount);
        }

## 😮‍💨 Now that’s quite a session with EIP-2981! 

🫂 Pat yourself on the shoulder, 

grab your favorite drink ☕ 

and we'll come back for a recap 🏁.
    
## **Summary**

### The current situation

At the time of this writing, EIP-2981 is still not supported widely by platforms. 

Coming back to the optional royalty topic that has been going on over Twitter, the discussion [here](https://eips.ethereum.org/EIPS/eip-2981#optional-royalty-payments[Rationale]) may help you to have a better understanding of the nature of ERC-2981. 

The standard is only a way to capture the royalty information and does not enforce its payment. It is then up to the martketplaces to honor and pay royalties together with the sales. 

### Looking into the future

Along with EIP-2981, there are also other token specs such as SuperRare, Rarible and Manifold, which all have the same function as EIP-2981, but the only difference is in their implementation. The race starts for developers to come up with a better model for managing NFT royalty. Magic Eden, a Solana NFT marketplace, announced a $1M on prize for this initiative.

![image](https://user-images.githubusercontent.com/48362877/196010077-b1a803bf-058c-41de-aae4-e660e4bbcf4f.png)

Another great tool built by Manifold.xyz in collaboration with marketplaces namely Foundation, Nifty Gateway, OpenSea, Rarible and SuperRare, is [Royalty Registry](https://royaltyregistry.xyz/lookup). It helps close the gap between the NFTs with different royalty specs and even onboard the old NFTs without an on-chain royalty support feature.

###  The importance of EIP-2981

Without an agreement on the way to share royalty information across platforms, it makes colleting ongoing funding hard for artists and creators and therefore, slows down the adoption of NFTs and Web3 in general.

With EIP-2981 providing NFT marketplaces with a single universal royalty payment standard not only makes it easier for artists and creators, but also benefit the entire NFT ecosystem in general.

--------

### Citation

1. Zach Burks, James Morgan, Blaine Malone, James Seibel, "EIP-2981: NFT Royalty Standard," Ethereum Improvement Proposals, no. 2981, September 2020. [Online serial]. Available: https://eips.ethereum.org/EIPS/eip-2981.

### Further Readings
1. [EIP-2981: NFT Royalty Standard](https://eips.ethereum.org/EIPS/eip-2981)
2. [Implementing EIP-2981 (ERC721 Royalties) #2789](https://github.com/OpenZeppelin/openzeppelin-contracts/issues/2789)
3. [See this discussion for more implementation of EIP-2981](https://forum.openzeppelin.com/t/has-anyone-implemented-eip-2981/14547)
