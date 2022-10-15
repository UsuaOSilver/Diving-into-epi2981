// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

import '../ERC2981Base.sol';

contract ERC721WithEIP2981 is ERC721, ERC2981Base {

  uint256 newTokenId;
  
  /**
   * @dev Initializes the contract.
   */
  constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}
  
  /**
   * @dev See {IERC165-supportsInterface}.
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
   * @param feeBasisPoints  Royalties value 
   */
  function setRoyaltyInfo(address receiver, uint96 feeBasisPoints)
      external
      /*onlyOwner*/
  {
      _setDefaultRoyalty(receiver, feeBasisPoints);
  }
  
  /**
   * @notice   Mint one token to address '_to'
   * @param to The address receiving the newly minted token
   */
  function mint(address _to) external {
      uint256 _tokenId = newTokenId;
      _safeMint(to, _tokenId, '');

      newTokenId = _tokenId + 1;
  }
}
