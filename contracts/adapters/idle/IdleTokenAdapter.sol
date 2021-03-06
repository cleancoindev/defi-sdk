// Copyright (C) 2020 Zerion Inc. <https://zerion.io>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.
//
// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.7.3;
pragma experimental ABIEncoderV2;

import { ERC20 } from "../../shared/ERC20.sol";
import { Component } from "../../shared/Structs.sol";
import { TokenAdapter } from "../TokenAdapter.sol";

/**
 * @dev IdleToken contract interface.
 * Only the functions required for IdleTokenAdapter contract are added.
 * The IdleToken contracts are available here
 * https://github.com/bugduino/idle-contracts/blob/master/contracts/IdleToken.sol
 * @author William Bergamo <william@idle.finance>
 */
interface IdleToken {
    function token() external view returns (address);

    function tokenPrice() external view returns (uint256);
}

/**
 * @title Token adapter for IdleTokens.
 * @dev Implementation of TokenAdapter abstract contract.
 */
contract IdleTokenAdapter is TokenAdapter {
    /**
     * @return Array of Component structs with underlying tokens rates for the given token.
     * @dev Implementation of TokenAdapter abstract contract function.
     */
    function getComponents(address token) external override returns (Component[] memory) {
        Component[] memory components = new Component[](1);

        components[0] = Component({
            token: IdleToken(token).token(),
            rate: int256(IdleToken(token).tokenPrice())
        });

        return components;
    }
}
