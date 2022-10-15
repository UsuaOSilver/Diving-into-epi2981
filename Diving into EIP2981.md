# Diving into EIP-2981

NFT Royalty has been a hot topic lately across Twitterr as collection experiment with 0% royalty and exchange implements optional royalty. 

This fires an issue of royalty honor. This is importance as it generate continuous support for the artists and creators.

This bring up a question to my mind. How has royalty been recorded since the first NFT?

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

     interface IERC2981 is IERC165 {

       function royaltyInfo(uint256 _tokenId, uint256 _salePrice) 
         external
         view
         returns (address receiver, uint256 royaltyAmount);
     }
     

### 📍 Now we put it into implementation with **ERC2981.sol**

The 2 most important funtions are `supportInterface()` & `royaltyInfo()`.     

     // SPDX-License-Identifier: MIT
     pragma solidity ^0.8.0;

     import '@openzeppelin/contracts/utils/introspection/ERC165.sol';

     import './IERC2981.sol';

     /// @dev This is a contract used to add ERC2981 support to ERC721 and 1155
     abstract contract ERC2981Base is IERC2981, ERC165 {
         struct RoyaltyInfo {
             address recipient;
             uint96 amount;
         }

         RoyaltyInfo private _RoyaltyInfo;
         mapping(uint256 => RoyaltyInfo) private _tokenToRoyaltyInfo;

         /**
          * @dev See {IERC165-supportsInterface}.
          */
         function supportsInterface(bytes4 interfaceId) 
             public 
             view 
             virtual 
             override(IERC165, ERC165) 
             returns (bool) 
         {
             return interfaceId == type(IERC2981).interfaceId || super.supportsInterface(interfaceId);
         }

         /**
          * @dev Sets the contract-wide royalty information (all ids).
          *
          * Requirements:
          *
          * - `_receiver` cannot be the zero address.
          * - `_amount` cannot be greater than the fee denominator.
          */
         function _setRoyalty(address _receiver, uint96 _amount) internal virtual {
             require(_amount <= 10000, "ERC2981: royalty fee exceeds salePrice");
             require(receiver != address(0), "ERC2981: invalid receiver address");

             _RoyaltyInfo = RoyaltyInfo(_receiver, _amount);
         }

         /**
          * @inheritdoc IERC2981
          */
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
     }
     
### 📍 Now let see EIP-2981 in action supporting an ERC721 contract.
     
     // SPDX-License-Identifier: MIT

     pragma solidity ^0.8.0;

     import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

     import '../ERC2981Base.sol';

     contract ERC721WithEIP2981 is ERC721, ERC2981 {

       uint256 newTokenId;

       /**
        * @dev Initializes the contract.
        */
       constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

       /**
        * @dev See {IERC2981-supportsInterface}.
        */
       function supportsInterface(bytes4 interfaceId)
           public
           view
           override(ERC721, ERC2981)
           returns (bool)
       {
           return super.supportsInterface(interfaceId);
       }

        /**
        * @notice Sets the contract-wide royalty info.
        * @dev This function should implement onlyOwner modifier in production.
        * @param receiver        The royalties recipient
        * @param amount  Royalties value 
        */
       function setRoyalty(address receiver, uint96 amount)
           external
           /*onlyOwner*/
       {
           _setRoyalty(receiver, amount);
       }

       /**
        * @notice   Mint one token to address '_to'
        * @param to The address receiving the newly minted token
        */
       function mint(address _to) external {
           uint256 _tokenId = newTokenId;
           _safeMint(_to, _tokenId, '');

           newTokenId = _tokenId + 1;
       }
     }



## 😮‍💨 Now that’s quite a session with EIP-2981! 

🫂 Pat yourself on the shoulder, 

grab your favorite drink ☕ 

and we'll come back for a recap 🏁.
    
## **Summary: The importance of EIP-2981**

Without an agreement on the way to share royalty information across platforms, it makes colleting ongoing funding hard for artists and creators and therefore, slows down the adoption of NFTs and Web3 in general.

Providing NFT marketplaces with a single universal royalty payment standard not only makes it easier for artists and creators, but also benefit the entire NFT ecosystem.

--------

### Citation

1. Zach Burks, James Morgan, Blaine Malone, James Seibel, "EIP-2981: NFT Royalty Standard," Ethereum Improvement Proposals, no. 2981, September 2020. [Online serial]. Available: https://eips.ethereum.org/EIPS/eip-2981.

### Further Readings
1. [EIP-2981: NFT Royalty Standard](https://eips.ethereum.org/EIPS/eip-2981)
2. [Implementing EIP-2981 (ERC721 Royalties) #2789](https://github.com/OpenZeppelin/openzeppelin-contracts/issues/2789)
3. [Royalty Registry](https://royaltyregistry.xyz/lookup)
