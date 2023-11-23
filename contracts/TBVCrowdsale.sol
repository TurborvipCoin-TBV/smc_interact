//SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/utils/SafeERC20.sol";
import "hardhat/console.sol";

contract TBVCrowdSale is Ownable {
    using SafeERC20 for IERC20;
    address payable public _wallet;
    uint256 public ETH_rate;
    uint256 public USDT_rate;
    IERC20 public token;
    IERC20 public usdtToken;

    event BuyTokenByETH(address buyer, uint256 amount);
    event BuyTokenByUSDT(address buyer, uint256 amount);
    event SetUSDTToken(IERC20 tokenAddress);
    event SetETHRate(uint256 newRate);
    event SetUSDTRate(uint256 newRate);

    constructor(
        uint256 eth_rate,
        uint256 usdt_rate,
        address payable wallet,
        IERC20 icotoken
    ) {
        ETH_rate = eth_rate;
        USDT_rate = usdt_rate;
        _wallet = wallet;
        token = icotoken;
    }

    function setUSDTToken(IERC20 token_address) public onlyOwner {
        usdtToken = token_address;
        emit SetUSDTToken(token_address);
    }

    function getUSDTToken() public onlyOwner view
        returns (address){
        return address(usdtToken);
    }

    function setETHRate(uint256 new_rate) public onlyOwner {
        ETH_rate = new_rate;
        emit SetETHRate(new_rate);
    }

    function setUSDTRate(uint256 new_rate) public onlyOwner {
        USDT_rate = new_rate;
        emit SetUSDTRate(new_rate);
    }

    function buyTokenByETH() external payable {
        uint256 ethAmount = msg.value;
        uint256 amount = getTokenAmountETH(ethAmount);
        require(amount > 0, "Amount is zero");
        require(
            token.balanceOf(address(this)) >= amount,
            "Insufficient account balance"
        );
        require(
            msg.sender.balance >= ethAmount,
            "Insufficient account balance"
        );
        payable(_wallet).transfer(ethAmount);
        SafeERC20.safeTransfer(token, msg.sender, amount);
        emit BuyTokenByETH(msg.sender, amount);
    }

    function buyTokenByUSDT(uint256 USDTAmount) external {
        uint256 amount = getTokenAmountUSDT(USDTAmount);
        console.log(usdtToken.balanceOf(address(token)),"  ", amount);
        require(
            msg.sender.balance >= USDTAmount,
            "Insufficient account balance 1"
        );
        require(amount > 0, "Amount is zero");
        require(
            usdtToken.balanceOf(address(this)) >= amount,
            "Insufficient account balance 2"
        );
        SafeERC20.safeTransferFrom(token, msg.sender, _wallet, USDTAmount);
        SafeERC20.safeTransfer(token, msg.sender, amount);
        emit BuyTokenByUSDT(msg.sender, amount);
    }

    function getTokenAmountETH(uint256 ETHAmount)
        public
        view
        returns (uint256)
    {
        return ETHAmount * ETH_rate;
    }

    function getTokenAmountUSDT(uint256 USDTAmount)
        public
        view
        returns (uint256)
    {
        return USDTAmount * USDT_rate;
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    function withdrawErc20() public onlyOwner {
        usdtToken.transfer(msg.sender, usdtToken.balanceOf(address(this)));
    }
}