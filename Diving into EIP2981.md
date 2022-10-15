# Diving into EIP-2981

![image](https://user-images.githubusercontent.com/48362877/196007439-850c1527-4c23-4a07-92aa-f8ae279f1e98.png)

NFT Royalty has been a hot topic lately across Twitter as collection such as DeGod experimenting with 0% royalty and exchange implements optional royalty. 

![image](https://user-images.githubusercontent.com/48362877/196007510-69754078-652f-41e9-878d-310108d5835d.png)

![image](https://user-images.githubusercontent.com/48362877/196007781-edd17148-7e40-4232-afba-5fcafff6af22.png)


This fires an issue of royalty honor. Royalty is an important topic as it is one of the largest source of continuous support for the artists and creators.

![image](https://user-images.githubusercontent.com/48362877/196007700-1df1bb6c-fdc4-4468-85e2-02856dc13109.png)

This brings up a question to my mind. How has royalty been recorded since the first NFT?

Understand this may clear up the context of royalty implementation.

**The problem**

Despite the popularity of NFT with them exchanging hands many times across different platforms, there has not been a standard way to easily and consistently transfer the royalty information to ensure artists and creators receive their set royalty across diferrent marketplaces or off chain.

This led to the proposal of EIP-2981.

## 👑 What is EIP-2981? 

"A standardized way to retrieve royalty payment information for non-fungible tokens (NFTs) to enable universal support for royalty payments across all NFT marketplaces and ecosystem participants."<sup>1</sup>
     
In short, 

## 🏗️ What can be built with it

EIP-2981 is a universal royalty standard and is not limited to the implementation of ERC-721 and ERC-1155 alone. As long as a contract is compatible with the constraints of EIP-2981, it can use this standard to retrieve royalty payment information.  

## 🧑‍🍳 A Demo

View the Github repo with the source code [here](https://github.com/UsuaOSilver/crystalize.dev-research/tree/main/contracts).

### 📍 Let’s start with **IERC2981.sol**

![image](https://user-images.githubusercontent.com/48362877/196006210-a6925a92-5b01-441d-ae58-df30e4ea47f3.png)

     interface IERC2981 is IERC165 {

       function royaltyInfo(uint256 _tokenId, uint256 _salePrice
       ) external
         view
         returns (address receiver, uint256 royaltyAmount);
     }
     

### 📍 Now we put it into implementation with **ERC2981.sol**

![image](https://user-images.githubusercontent.com/48362877/196006164-692c8cf9-f8a4-4824-b287-e0e592aa130e.png)

We bundle the information needed into a `RoyaltyInfo` struct

     struct RoyaltyInfo {
         address recipient;
         uint96 amount;
     }
     
The 2 most important funtions are `supportInterface()` & `royaltyInfo()`.     




     
### 📍 Now let see EIP-2981 in action supporting an ERC721 contract.

![image](https://user-images.githubusercontent.com/48362877/196006101-612aa307-6181-4f43-9619-ab34d55bfb8d.png)


## 😮‍💨 Now that’s quite a session with EIP-2981! 

🫂 Pat yourself on the shoulder, 

grab your favorite drink ☕ 

and we'll come back for a recap 🏁.
    
## **Summary**

### The Current Situation

At the time of this writing, EIP-2981 is still not supported widely by platforms. 

Coming back to the optional royalty topic that has been going on over Twitter, the discussion [here](https://eips.ethereum.org/EIPS/eip-2981#optional-royalty-payments[Rationale]) may help you to have a better understanding of the nature of ERC-2981. 

The standard is only a way to capture the royalty information and does not enforce its payment. It is then up to the martketplaces to honor and pay royalties together with the sales. 

###  The importance of EIP-2981

Without an agreement on the way to share royalty information across platforms, it makes colleting ongoing funding hard for artists and creators and therefore, slows down the adoption of NFTs and Web3 in general.

Providing NFT marketplaces with a single universal royalty payment standard not only makes it easier for artists and creators, but also benefit the entire NFT ecosystem.

--------

### Citation

1. Zach Burks, James Morgan, Blaine Malone, James Seibel, "EIP-2981: NFT Royalty Standard," Ethereum Improvement Proposals, no. 2981, September 2020. [Online serial]. Available: https://eips.ethereum.org/EIPS/eip-2981.

### Further Readings
1. [EIP-2981: NFT Royalty Standard](https://eips.ethereum.org/EIPS/eip-2981)
2. [Implementing EIP-2981 (ERC721 Royalties) #2789](https://github.com/OpenZeppelin/openzeppelin-contracts/issues/2789)
3. [Royalty Registry](https://royaltyregistry.xyz/lookup)
