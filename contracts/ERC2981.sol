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
    function royaltyInfo(uint256 _tokenId, uint256 _salePrice) public view virtual override returns (address, uint256) {
        RoyaltyInfo memory royalty = _tokenToRoyaltyInfo;

        if (royalty.receiver == address(0)) {
            royalty = _RoyaltyInfo;
        }

        uint256 royaltyAmount = (_salePrice * royalty.amount) / 10000;

        return (royalty.receiver, royaltyAmount);
    }
}
