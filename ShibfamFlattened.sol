// SPDX-License-Identifier: MIT
// @dev ow3
pragma solidity ^0.6.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, 'SafeMath: addition overflow');

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, 'SafeMath: subtraction overflow');
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, 'SafeMath: multiplication overflow');

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, 'SafeMath: division by zero');
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, 'SafeMath: modulo by zero');
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;

        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, 'Address: insufficient balance');

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}('');
        require(success, 'Address: unable to send value, recipient may have reverted');
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, 'Address: low-level call failed');
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, 'Address: low-level call with value failed');
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, 'Address: insufficient balance for call');
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        require(isContract(target), 'Address: call to non-contract');

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), 'Ownable: caller is not the owner');
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), 'Ownable: new owner is the zero address');
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Pair {
    function sync() external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;
}

pragma solidity ^0.6.0;

abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() public {
        _status = _NOT_ENTERED;
    }

    modifier nonReentrant() {
        require(_status != _ENTERED, 'ReentrancyGuard: reentrant call');
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }

    modifier isHuman() {
        require(tx.origin == msg.sender, 'sorry humans only');
        _;
    }
}

pragma solidity ^0.6.0;

library TransferHelper {
    function safeApprove(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeApprove: approve failed'
        );
    }

    function safeTransfer(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeTransfer: transfer failed'
        );
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::transferFrom: transferFrom failed'
        );
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, 'TransferHelper::safeTransferETH: ETH transfer failed');
    }
}

interface IFeeReceiver {
    function onFeeReceived(uint256 amount) external payable;
}

contract FeeReceiver is IFeeReceiver, Ownable {
    address public vault;
    constructor(address _owner, address _vault) public {
        vault = _vault;
        transferOwnership(_owner);
    }

    receive() external payable {}

    function onFeeReceived(uint256 amount) override external payable {
        if(vault != address(0))
            payable(vault).transfer(amount);
    }
    
    function setVault(address _vault) external onlyOwner {
        vault = _vault;
    }

    function withdrawAccidentallySentTokens(IERC20 token, address recipient, uint256 amount) external onlyOwner {
        token.transfer(recipient, amount);
    }

    function withdrawAccidentallySentEth(address payable recipient, uint256 amount) external onlyOwner {
        recipient.transfer(amount);
    }
}

abstract contract BPContract{
    function protect( address sender, address receiver, uint256 amount ) external virtual;
}

contract Shibafam is Context, IERC20, Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    using Address for address;  
    using TransferHelper for address;

    address DEAD = 0x000000000000000000000000000000000000dEaD;

    string private _name = 'Shibafam';
    string private _symbol = 'SHFM';
    uint8 private _decimals =  18;

    mapping(address => uint256) internal _reflectionBalance;
    mapping(address => uint256) internal _tokenBalance;
    mapping(address => mapping(address => uint256)) internal _allowances;

    uint256 private constant MAX = ~uint256(0);
    uint256 internal _tokenTotal = 500_000_000_000_000e9;
    uint256 internal _reflectionTotal = (MAX - (MAX % _tokenTotal));

    mapping(address => bool) public isTaxless;
    mapping(address => bool) internal _isExcluded;
    address[] internal _excluded;

    uint256 public _feeDecimal = 2;
    // index 0 = buy fee, index 1 = sell fee, index 2 = p2p fee
    uint256[] internal _taxFee;
    uint256[] public _liqFee;
    uint256[] public _vaultFee;
    uint256[] public _marketingFee;
    uint256[] public _buybackFee;

    uint256 internal _feeTotal;
    uint256 internal _liqFeeCollected;
    uint256 internal _vaultFeeCollected;
    uint256 internal _marketingFeeCollected;
    uint256 internal _buybackFeeCollected;

    uint256 public buybackTotal;

    bool public isFeeActive = false; // should be true
    bool private inSwap;
    bool public swapEnabled = true;

    uint256 public minTokensBeforeSwap = 1_000_000e9;
    uint256 public maxSwapPercent = 10; // 0.1%
    uint256 public swapInterval = 1 hours;
    uint256 public lastSwapTimestamp = block.timestamp;

    address public marketingWallet;
    address public buybackWallet;
    IFeeReceiver public feeReceiver;

    IUniswapV2Router02 public router;
    address public pair;

    BPContract public BP;
    bool public bpEnabled;
    bool public BPDisabledForever = false;

    event SwapIntervalUpdated(uint256 invertval);
    event SwapUpdated(bool enabled);
    event Swap(uint256 tokensSwapped, uint256 bnbReceived, uint256 tokensIntoLiqudity);
    event AutoLiquify(uint256 bnbAmount, uint256 tokenAmount);
    event BuybackAndBurned(uint256 bnbAmount, uint256 tokenAmount);

    modifier lockTheSwap() {
        inSwap = true;
        _;
        inSwap = false;
    }

    constructor(address _router ,address _owner,address _marketingWallet, address _vault, address _buybackWallet) public {
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(_router);
        pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH());
        router = _uniswapV2Router;
        marketingWallet = _marketingWallet;
        buybackWallet = _buybackWallet;
        feeReceiver = new FeeReceiver(_owner, _vault);

        isTaxless[_owner] = true;
        isTaxless[address(_vault)] = true;
        isTaxless[address(feeReceiver)] = true;
        isTaxless[_marketingWallet] = true;
        isTaxless[_buybackWallet] = true;
        isTaxless[address(this)] = true;

        _reflectionBalance[_owner] = _reflectionTotal;
        emit Transfer(address(0),_owner, _tokenTotal);

        _taxFee.push(0);
        _taxFee.push(0);
        _taxFee.push(0);

        _liqFee.push(100);
        _liqFee.push(100);
        _liqFee.push(0);

        _vaultFee.push(100);
        _vaultFee.push(500);
        _vaultFee.push(0);

        _marketingFee.push(100);
        _marketingFee.push(100);
        _marketingFee.push(0);

        _buybackFee.push(100);
        _buybackFee.push(100);
        _buybackFee.push(0);

        transferOwnership(_owner);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tokenTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        if (_isExcluded[account]) return _tokenBalance[account];
        return tokenFromReflection(_reflectionBalance[account]);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(amount, 'ERC20: transfer amount exceeds allowance')
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].sub(subtractedValue, 'ERC20: decreased allowance below zero')
        );
        return true;
    }

    function isExcluded(address account) public view returns (bool) {
        return _isExcluded[account];
    }

    function tokenFromReflection(uint256 reflectionAmount) internal view returns (uint256) {
        require(reflectionAmount <= _reflectionTotal, 'Amount must be less than total reflections');
        uint256 currentRate = _getReflectionRate();
        return reflectionAmount.div(currentRate);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) private {
        require(owner != address(0), 'ERC20: approve from the zero address');
        require(spender != address(0), 'ERC20: approve to the zero address');

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) private {
        require(sender != address(0), 'ERC20: transfer from the zero address');
        require(recipient != address(0), 'ERC20: transfer to the zero address');
        require(amount > 0, 'Transfer amount must be greater than zero');

        if (bpEnabled && !BPDisabledForever) {
            BP.protect(sender, recipient, amount); 
        }

        if (swapEnabled && !inSwap && sender != pair) {
            swap();
        }

        uint256 transferAmount = amount;
        uint256 rate = _getReflectionRate();

        if (isFeeActive && !isTaxless[sender] && !isTaxless[recipient] && !inSwap) {
            transferAmount = collectFee(sender, amount, rate, recipient == pair, sender != pair && recipient != pair);
        }

        //transfer reflection
        _reflectionBalance[sender] = _reflectionBalance[sender].sub(amount.mul(rate));
        _reflectionBalance[recipient] = _reflectionBalance[recipient].add(transferAmount.mul(rate));

        //if any account belongs to the excludedAccount transfer token
        if (_isExcluded[sender]) {
            _tokenBalance[sender] = _tokenBalance[sender].sub(amount);
        }
        if (_isExcluded[recipient]) {
            _tokenBalance[recipient] = _tokenBalance[recipient].add(transferAmount);
        }

        emit Transfer(sender, recipient, transferAmount);
    }

    function calculateFee(uint256 feeIndex, uint256 amount) 
    internal returns(uint256 taxFee, uint256 marketingFee,uint256 totalFee) {
        taxFee = amount.mul(_taxFee[feeIndex]).div(10**(_feeDecimal + 2));
        marketingFee = amount.mul(_marketingFee[feeIndex]).div(10**(_feeDecimal + 2));
        uint256 liqFee = amount.mul(_liqFee[feeIndex]).div(10**(_feeDecimal + 2));
        uint256 vaultFee = amount.mul(_vaultFee[feeIndex]).div(10**(_feeDecimal + 2));
        uint256 buybackFee = amount.mul(_buybackFee[feeIndex]).div(10**(_feeDecimal + 2));
        totalFee = liqFee.add(vaultFee).add(buybackFee);

        _liqFeeCollected = _liqFeeCollected.add(liqFee);
        _vaultFeeCollected = _vaultFeeCollected.add(vaultFee);
        _buybackFeeCollected = _buybackFeeCollected.add(buybackFee);
    }

    function collectFee(
        address account,
        uint256 amount,
        uint256 rate,
        bool sell,
        bool p2p
    ) private returns (uint256) {
        uint256 transferAmount = amount;

        (uint256 taxFee, uint256 marketingFee, uint256 otherFee) = calculateFee(p2p ? 2 : sell ? 1 : 0, amount);
        if(otherFee != 0) {
            transferAmount = transferAmount.sub(otherFee);
            _reflectionBalance[address(this)] = _reflectionBalance[address(this)].add(otherFee.mul(rate));
            if (_isExcluded[address(this)]) {
                _tokenBalance[address(this)] = _tokenBalance[address(this)].add(otherFee);
            }
            emit Transfer(account, address(this), otherFee);
        }
        if(marketingFee != 0) {
            transferAmount = transferAmount.sub(marketingFee);
            _reflectionBalance[marketingWallet] = _reflectionBalance[marketingWallet].add(marketingFee.mul(rate));
            if (_isExcluded[marketingWallet]) {
                _tokenBalance[marketingWallet] = _tokenBalance[marketingWallet].add(marketingFee);
            }
            emit Transfer(account, marketingWallet, marketingFee);
        }
        if(taxFee != 0) {
            transferAmount = transferAmount.sub(taxFee);
            _reflectionTotal = _reflectionTotal.sub(taxFee.mul(rate));
        }
        _feeTotal = _feeTotal.add(taxFee).add(otherFee).add(marketingFee);
        return transferAmount;
    }

    function getAmountToSwap() internal returns(uint256 liqFeeTotal, uint256 valutFeeTotal, uint256 buybackFeeTotal)  {
        uint256 maxTokensBeforeSwap = balanceOf(pair).mul(maxSwapPercent).div(10000);
        if(_liqFeeCollected > maxTokensBeforeSwap) {
            _liqFeeCollected = _liqFeeCollected.sub(maxTokensBeforeSwap);
            liqFeeTotal = maxTokensBeforeSwap;
            return(liqFeeTotal, valutFeeTotal, buybackFeeTotal);
        }
        uint256 totalFee = _liqFeeCollected;
        liqFeeTotal = _liqFeeCollected;
        _liqFeeCollected = 0;
        if(totalFee.add(_vaultFeeCollected) > maxTokensBeforeSwap) {
            uint256 extraTokens = totalFee.add(_vaultFeeCollected).sub(maxTokensBeforeSwap);
            valutFeeTotal = _vaultFeeCollected.sub(extraTokens);
            _vaultFeeCollected = extraTokens;
            return(liqFeeTotal, valutFeeTotal, buybackFeeTotal);
        }
        totalFee = totalFee.add(_vaultFeeCollected);
        valutFeeTotal = _vaultFeeCollected;
        _vaultFeeCollected = 0;
        if(totalFee.add(_buybackFeeCollected) > maxTokensBeforeSwap) {
            uint256 extraTokens = totalFee.add(_buybackFeeCollected).sub(maxTokensBeforeSwap);
            buybackFeeTotal = _buybackFeeCollected.sub(extraTokens);
            _buybackFeeCollected = extraTokens;
            return(liqFeeTotal, valutFeeTotal, buybackFeeTotal);
        }
        totalFee = totalFee.add(_buybackFeeCollected);
        buybackFeeTotal = _buybackFeeCollected;
        _buybackFeeCollected = 0;
    }

    function swap() private lockTheSwap {
        (uint256 liqFeeTotal, uint256 valutFeeTotal, uint256 buybackFeeTotal)  = getAmountToSwap();
        uint256 totalFee = liqFeeTotal.add(valutFeeTotal).add(buybackFeeTotal);

        if(minTokensBeforeSwap > totalFee || lastSwapTimestamp + swapInterval >= block.timestamp) return;
        lastSwapTimestamp = block.timestamp;

        uint256 amountToLiquify = totalFee.mul(liqFeeTotal).div(totalFee).div(2);
        uint256 amountToSwap = totalFee.sub(amountToLiquify);

        address[] memory sellPath = new address[](2);
        sellPath[0] = address(this);
        sellPath[1] = router.WETH();       

        uint256 balanceBefore = address(this).balance;
        uint256 amountBNBLiquidity;

        _approve(address(this), address(router), totalFee);
        try router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amountToSwap,
            0,
            sellPath,
            address(this),
            block.timestamp
        ) {
            uint256 amountBNB = address(this).balance.sub(balanceBefore);

            uint256 totalBNBFee = totalFee.sub(liqFeeTotal.div(2));
            amountBNBLiquidity = amountBNB.mul(liqFeeTotal).div(totalBNBFee).div(2);
            uint256 amountBNBVault = amountBNB.mul(valutFeeTotal).div(totalBNBFee);
            // uint256 amountBNBBuyback = amountBNB.sub(amountBNBLiquidity).sub(amountBNBVault);

            if(amountBNBVault > 0) {
                feeReceiver.onFeeReceived{value: amountBNBVault}(amountBNBVault);
            }
        }
        catch {}

        if(amountToLiquify > 0) {
            try router.addLiquidityETH{value: amountBNBLiquidity}(
                address(this),
                amountToLiquify,
                0,
                0,
                DEAD,
                block.timestamp
            ) {
                emit AutoLiquify(amountBNBLiquidity, amountToLiquify);
            }
            catch {}
        }
    }

    function swapEthForTokens(uint256 amount) private returns (bool) {
        address[] memory path = new address[](2);
        path[0] = router.WETH();
        path[1] = address(this);

        try router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: amount}(
                0,
                path,
                address(buybackWallet), //@dev Uniswap doesn't allow for a token to buy itself, so we have to use an external account
                block.timestamp
            ) { return true; }
        catch { return false; }
    }
   
    function buyAndBurnToken(uint256 amount) external lockTheSwap onlyOwner {
        require(amount <= address(this).balance, "Insuficent Balance to burn tokens!");

        bool success =  swapEthForTokens(amount);

        if(success) {
            //@dev How much tokens we swaped into
            uint256 swapedTokens = balanceOf(address(buybackWallet));

            uint256 rate =  _getReflectionRate();

            _reflectionBalance[address(buybackWallet)] = 0;
            if (_isExcluded[address(buybackWallet)]) {
                _tokenBalance[address(buybackWallet)] = 0;
            }
            
            buybackTotal = buybackTotal.add(swapedTokens);
            _tokenTotal = _tokenTotal.sub(swapedTokens);
            _reflectionTotal = _reflectionTotal.sub(swapedTokens.mul(rate));
            
            emit Transfer(address(buybackWallet), address(0), swapedTokens);
            emit BuybackAndBurned(amount, swapedTokens);
        }
    }

    function _getReflectionRate() private view returns (uint256) {
        uint256 reflectionSupply = _reflectionTotal;
        uint256 tokenSupply = _tokenTotal;
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_reflectionBalance[_excluded[i]] > reflectionSupply || _tokenBalance[_excluded[i]] > tokenSupply)
                return _reflectionTotal.div(_tokenTotal);
            reflectionSupply = reflectionSupply.sub(_reflectionBalance[_excluded[i]]);
            tokenSupply = tokenSupply.sub(_tokenBalance[_excluded[i]]);
        }
        if (reflectionSupply < _reflectionTotal.div(_tokenTotal)) return _reflectionTotal.div(_tokenTotal);
        return reflectionSupply.div(tokenSupply);
    }

    function setTaxless(address account, bool value) external onlyOwner {
        isTaxless[account] = value;
    }

    function setSwapEnabled(bool enabled) external onlyOwner {
        swapEnabled = enabled;
        SwapUpdated(enabled);
    }

    function setFeeActive(bool value) external onlyOwner {
        isFeeActive = value;
    }

    function setBNBVaultFee(uint256 buy, uint256 sell, uint256 p2p) external onlyOwner {
        require(buy <= 1000 && sell <= 1000 && p2p <= 1000, "Fee out of range!");
        
        _vaultFee[0] = buy;
        _vaultFee[1] = sell;
        _vaultFee[2] = p2p;
    }


    function setMarketingFee(uint256 buy, uint256 sell, uint256 p2p) external onlyOwner {
        require(buy <= 1000 && sell <= 1000 && p2p <= 1000, "Fee out of range!");

        _marketingFee[0] = buy;
        _marketingFee[1] = sell;
        _marketingFee[2] = p2p;
    }

    function setLiquidityFee(uint256 buy, uint256 sell, uint256 p2p) external onlyOwner {
        require(buy <= 1000 && sell <= 1000 && p2p <= 1000, "Fee out of range!");

        _liqFee[0] = buy;
        _liqFee[1] = sell;
        _liqFee[2] = p2p;
    }

    function setBuybackFee(uint256 buy, uint256 sell, uint256 p2p) external onlyOwner {
        require(buy <= 1000 && sell <= 1000 && p2p <= 1000, "Fee out of range!");

        _buybackFee[0] = buy;
        _buybackFee[1] = sell;
        _buybackFee[2] = p2p;
    }

    function setMarketingWallet(address wallet) external onlyOwner {
        marketingWallet = wallet;
    }

    function setVaultFeeReceiver(IFeeReceiver _feeReceiver)  external onlyOwner {
        require(address(_feeReceiver) != address(0));
        feeReceiver = _feeReceiver;
    }

    function setSwapInterval(uint256 interval) external onlyOwner {
        swapInterval = interval;
        emit SwapIntervalUpdated(interval);
    }

    function setMinTokensBeforeSwap(uint256 amount) external onlyOwner {
        minTokensBeforeSwap = amount;
    }

    function setMaxPercent(uint256 percent) external onlyOwner {
        maxSwapPercent = percent;
    }

    function withdrawAccidentallySentTokens(IERC20 token, address recipient, uint256 amount) external onlyOwner {
        require(address(token) != address(this), "Token not allowed!");
        token.transfer(recipient, amount);
    }


    receive() external payable {}
    
    function setBPAddrss(address _bp) external onlyOwner {
        require(address(BP)== address(0), "Can only be initialized once");
        BP = BPContract(_bp);
    }

    function setBpEnabled(bool _enabled) external onlyOwner {
        bpEnabled = _enabled;
    }

    function setBotProtectionDisableForever() external onlyOwner{
        require(BPDisabledForever == false);
        BPDisabledForever = true;
    }
}
