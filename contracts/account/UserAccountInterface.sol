pragma solidity >=0.5.0 <0.7.0;

import "./ERC725.sol";
import "./Signer.sol";
/**
 * @author Ricardo Guilherme Schmidt (Status Research & Development GmbH)
 * @notice A common user account interface
 */
contract UserAccountInterface is ERC725, Signer {

    /**
     * @notice calls another contract
     * @param _to destination of call
     * @param _value call ether value (in wei)
     * @param _data call data
     * @return internal transaction status and returned data
     */
    function call(
        address _to,
        uint256 _value,
        bytes calldata _data
    )
        external
        returns(bool success, bytes memory returndata);

    /**
     * @notice Approves `_to` spending ERC20 `_baseToken` a total of `_value` and calls `_to` with `_data`. Useful for a better UX on ERC20 token use, and avoid race conditions.
     * @param _baseToken ERC20 token being approved to spend
     * @param _to Destination of contract accepting this ERC20 token payments through approve
     * @param _value amount of ERC20 being approved
     * @param _data abi encoded calldata to be executed in `_to` after approval.
     * @return internal transaction status and returned data
     */
    function approveAndCall(
        address _baseToken,
        address _to,
        uint256 _value,
        bytes calldata _data
    )
        external
        returns(bool success, bytes memory returndata);

    /**
     * @notice creates new contract based on input `_code` and transfer `_value` ETH to this instance
     * @param _value amount ether in wei to sent to deployed address at its initialization
     * @param _code contract code
     * @return creation success status and created contract address
     */
    function create(
        uint256 _value,
        bytes calldata _code
    )
        external
        returns(address createdContract);

    /**
     * @notice creates deterministic address contract using on input `_code` and transfer `_value` ETH to this instance
     * @param _value amount ether in wei to sent to deployed address at its initialization
     * @param _code contract code
     * @param _salt changes the resulting address
     * @return creation success status and created contract address
     */
    function create2(
        uint256 _value,
        bytes calldata _code,
        bytes32 _salt
    )
        external
        returns(address createdContract);

    /**
     * @notice Defines recoveryContract address.
     * @param _recovery address of recoveryContract contract
     */
    function setRecovery(address _recovery) external;

    /**
     * @notice Changes actor contract
     * @param _actor Contract which can call actions from this contract
     */
    function setActor(address _actor) external;

    /**
     * @notice Replace owner address.
     * @param newOwner address of externally owned account or ERC1271 contract to control this account
     */
    function changeOwner(address newOwner) external;

    /**
     * @notice Defines the new owner and disable actor. Can only be called by recovery.
     * @param newOwner an ERC1271 contract
     */
    function recover(address newOwner) external;
}