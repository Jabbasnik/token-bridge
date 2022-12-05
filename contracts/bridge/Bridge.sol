// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../interface/BridgeBase.sol";
import "../tokens/WERC20Factory.sol";
import "../tokens/WERC20.sol";

contract Bridge is Ownable {
    WERC20Factory public tokenFactory;

    mapping(address => address) public wrappedNativeMapping;

    event Locked();
    event Claimed();
    event Burned();
    event Minted();

    constructor() {
        tokenFactory = new WERC20Factory();
    }

    function lock(
        address _account,
        address _tokenAddress,
        uint256 _amount // uint16 _chainId
    ) external {
        WERC20(_tokenAddress).transferFrom(_account, address(this), _amount);

        emit Locked();
    }

    function claim(
        address _to,
        address _tokenAddress,
        uint256 _amount
    ) external {
        WERC20(_tokenAddress).transfer(_to, _amount);

        emit Claimed();
    }

    function mint(
        address _to,
        address _tokenAddress,
        uint256 _amount
    ) external {
        WERC20 wrappedToken = tokenFactory.getTokenByAddress(_tokenAddress);
        wrappedToken.mint(_to, _amount);

        emit Minted();
    }

    function burn(
        address _tokenAddress,
        address _account,
        uint256 _amount
    ) external {
        WERC20 wrappedToken = tokenFactory.getTokenByAddress(_tokenAddress);

        wrappedToken.burnFrom(_account, _amount);
        emit Burned();
    }

    function createToken(string calldata _name, string calldata _symbol)
        external
    {
        tokenFactory.createToken(_name, _symbol);
    }
}
