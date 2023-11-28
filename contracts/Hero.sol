//SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

import "openzeppelin-solidity/contracts/utils/Context.sol";
import "openzeppelin-solidity/contracts/utils/Counters.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-solidity/contracts/access/AccessControlEnumerable.sol";

interface IHero {
    function mint(address to, uint256 hero_type, string memory tokenURI) external returns (uint256);
}

contract Hero is ERC721Enumerable, ERC721URIStorage, Ownable, AccessControlEnumerable, IHero {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;
    string private _url;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event Mint(address to, uint256 hero_type, uint256 tokenid);

    constructor() ERC721("Anime Turborvip", "Turborvip") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function _baseURI() internal view override returns (string memory) {
        return _url;
    }

    function mint(address to, uint256 hero_type, string memory tokenURI) external override returns (uint256) {
                require(owner() == _msgSender()||hasRole(MINTER_ROLE,_msgSender()), "Caller is not a minter");


        _tokenIdTracker.increment();
        uint256 token_id = _tokenIdTracker.current();
        _mint(to, token_id);
        _setTokenURI(token_id, tokenURI);

        emit Mint(to, hero_type, token_id);
        return token_id;
    }

    function listTokenIds(address owner) external view returns (uint256[] memory tokenIds) {
        uint balance = balanceOf(owner);
        uint256[] memory ids = new uint256[](balance);

        for (uint i = 0; i < balance; i++) {
            ids[i] = tokenOfOwnerByIndex(owner, i);
        }
        return ids;
    }

    function setBaseUrl(string memory _newUrl) public onlyOwner {
        _url = _newUrl;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable, AccessControlEnumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
    
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
}
