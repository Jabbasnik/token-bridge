// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WERC20 is ERC20PresetMinterPauser, Ownable {
    constructor(string memory _name, string memory _symbol)
        ERC20PresetMinterPauser(_name, _symbol)
    {}

    // function mint(address _recipient, uint256 _amount)
    //     public
    //     virtual
    //     onlyOwner
    // {
    //     _mint(_recipient, _amount);
    // }

    function burnFrom(address _account, uint256 _amount)
        public
        virtual
        override(ERC20Burnable)
        onlyOwner
    {
        super.burnFrom(_account, _amount);
    }
}
