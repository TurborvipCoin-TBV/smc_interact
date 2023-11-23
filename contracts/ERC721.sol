//SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

contract ERC721 {
    event Transfer(address indexed _from,address indexed _to,uint256 indexed _tokenId);
    event Approval(address indexed _owner,address indexed _approved,uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner,address indexed _operator,bool _approved);

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprivals;
    mapping(uint256 => address) private _tokenApproves;

    // return the number of nfts of an user
    function balanceOf(address owner) external view returns (uint256){
        require(owner != address(0),"Address is zero");
        return _balances[owner];
    }

    // find the owner of nft
    function ownerOf(uint256 tokenId) public view returns (address){
        address owner = _owners[tokenId];
        require(owner != address(0),"TokenID doase not exist");
        return owner;
    }

    // enable or disable an operator
    function setApprovalForAll(address operator, bool approved) external{
        _operatorApprivals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender,operator,approved);
    }

    // check if an address is an operator for another address
    function isApprovedForAll(address owner,address operator) public view returns (bool){
        return _operatorApprivals[owner][operator];
    }

    // updates an approved address for a NFT
    function approve(address to, uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || isApprovedForAll(owner,msg.sender),"msg.sender is not the owner or the approved operator");
        _tokenApproves[tokenId] = to;
        emit Approval(owner,to,tokenId);
    }

    // gets the approved address for a NFT
    function getApproved(uint256 tokenId) public view returns (address){
        require(_owners[tokenId] != address(0),"Token ID is not exist");
        return _tokenApproves[tokenId];
    }

    // tranfer ownership of a single NFT
    function transferFrom(address from,address to,uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);

        require(
            msg.sender == owner ||
            getApproved(tokenId) == msg.sender ||
            isApprovedForAll(owner, msg.sender),
            "msg.sender is not owner or approved for tranfer"
        );

        require(from == owner,"From is not owner");

        require(to != address(0),"Address is zero address");

        require(_owners[tokenId] != address(0),"Token Id is not exist");

        approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to]   += 1;

        _owners[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }

    // standard tranferFrom method
    // check if the recieve smart contract is capable of receiving NFTs
    function safeTransferFrom(address from,address to,uint256 tokenId, bytes memory _data) public payable{
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(),"Receiver is not implementd");
    }

    // simple version to check for nft receivability of a smart contract
    function _checkOnERC721Received() private pure returns(bool){
        return true;
    }

    function safeTransferFrom(address from,address to,uint256 tokenId) external payable{
        safeTransferFrom(from, to, tokenId, "");
    }

    // EIP165 proposal: query if a contract implements another interface
    function supportInterface(bytes4 interfaceID) public pure virtual returns(bool){
        return interfaceID == 0x80ac58cd;
    }
}
