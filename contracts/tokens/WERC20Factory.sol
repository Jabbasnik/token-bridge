// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./WERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WERC20Factory is Ownable {
    mapping(address => WERC20) private wrappedTokensAddressRegistry;
    mapping(string => WERC20) private wrappedTokensSymbolRegistry;

    event Created(
        string name,
        string symbol,
        address indexed createdTokenAddress
    );

    function createToken(string memory _name, string memory _symbol)
        external
        onlyOwner
    {
        require(
            address(wrappedTokensSymbolRegistry[_symbol]) != address(0),
            "Token already exists!"
        );

        WERC20 wrappedToken = new WERC20(_name, _symbol);
        address wrappedTokenAddress = address(wrappedToken);
        wrappedTokensAddressRegistry[wrappedTokenAddress] = wrappedToken;
        wrappedTokensSymbolRegistry[_symbol] = wrappedToken;
        emit Created(_name, _symbol, wrappedTokenAddress);
    }

    function getTokenByAddress(address _token) public view returns (WERC20) {
        return wrappedTokensAddressRegistry[_token];
    }

    function getTokenBySymbol(string memory _symbol) public view returns (WERC20) {
        return wrappedTokensSymbolRegistry[_symbol];
    }
}
