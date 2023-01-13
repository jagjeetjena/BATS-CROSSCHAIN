pragma solidity ^0.8.0;

import "@routerprotocol/router-crosstalk/contracts/RouterCrossTalk.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

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
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}



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
        require(c >= a, "SafeMath: addition overflow");

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
        return sub(a, b, "SafeMath: subtraction overflow");
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
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
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
        require(c / a == b, "SafeMath: multiplication overflow");

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
        return div(a, b, "SafeMath: division by zero");
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
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
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
        return mod(a, b, "SafeMath: modulo by zero");
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
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}



interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}





interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}






interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}


interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


interface IPinkAntiBot {
  function setTokenOwner(address owner) external;

  function onPreTransferCheck(
    address from,
    address to,
    uint256 amount
  ) external;
}

contract BattleSquad_BSC is ERC20, Ownable, AccessControl, RouterCrossTalk {
    uint256 private _crossChainGasLimit;
    uint256 private _crossChainGasPrice;
    using SafeMath for uint256;

    IUniswapV2Router02 public uniswapV2Router;
    address public  uniswapV2Pair;

    bool private feeActive = false;
    bool public transferFeeEnabled = false;
    bool public tradingEnabled =  true;
    uint256 public launchTime;

    uint256 internal totaltokensupply = 100000000 * (10**18);
    uint256 public selfDestructCode = 0;


    address public deadWallet = 0x000000000000000000000000000000000000dEaD;

    mapping(address => bool) public _isBlacklisted;

    IPinkAntiBot public pinkAntiBot;

    uint256 public buyFee = 0;
    uint256 public sellFee = 5;
    uint256 public burnFeePercent = 5;
    uint256 public maxtranscation = 50000000000000000000000;
    uint256 public transferTax = 5;

    bool public antiBotEnabled;
    bool public antiDumpEnabled = false;


    address public feeWallet     = 0x177b99CE1f0De634155F88372265C4542b72aEe5;
    address public pinkAntiBot_  = 0x8EFDb3b642eb2a20607ffe0A56CFefF6a95Df002;
    address public _genericHandler = 0x22a240968D41e4FaC43b5d5DC8A39C3e96EC5da7;


     // exclude from fees and max transaction amount
    mapping (address => bool) private _isExcludedFromFees;

    mapping (address => uint256) public antiDump;
    mapping (address => uint256) public sellingTotal;
    mapping (address => uint256) public lastSellstamp;
    uint256 public antiDumpTime = 10 minutes;
    uint256 public antiDumpAmount = totaltokensupply.mul(5).div(10000);



    // store addresses that a automatic market maker pairs. Any transfer *to* these addresses
    // could be subject to a maximum transfer amount
    mapping (address => bool) public automatedMarketMakerPairs;


    event UpdateUniswapV2Router(address indexed newAddress, address indexed oldAddress);

    event ExcludeFromFees(address indexed account, bool isExcluded);
    event ExcludeMultipleAccountsFromFees(address[] accounts, bool isExcluded);

    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);

    event LiquidityWalletUpdated(address indexed newLiquidityWallet, address indexed oldLiquidityWallet);

    constructor()
        RouterCrossTalk(_genericHandler)
        ERC20("BattleSquad", "BATS")
        AccessControl()
    {
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
         // Create a uniswap pair for this new token
        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());

        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = _uniswapV2Pair;

        _setAutomatedMarketMakerPair(_uniswapV2Pair, true);
        pinkAntiBot = IPinkAntiBot(pinkAntiBot_);
        pinkAntiBot.setTokenOwner(msg.sender);
        antiBotEnabled = true;

        // exclude from paying fees or having max transaction amount
        excludeFromFees(owner(), true);
        excludeFromFees(address(this), true);

        /*
            _mint is an internal function in ERC20.sol that is only called here,
            and CANNOT be called ever again
        */
        _mint(owner(), totaltokensupply);
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    receive() external payable {

  	}

    function setEnableAntiBot(bool _enable) external onlyOwner {
        antiBotEnabled = _enable;
    }

    function setantiDumpEnabled(bool nodumpamount) external onlyOwner {
        antiDumpEnabled = nodumpamount;
    }

    function setantiDump(uint256 interval, uint256 amount) external onlyOwner {
        antiDumpTime = interval;
        antiDumpAmount = amount;
    }

    function updateUniswapV2Router(address newAddress) public onlyOwner {
        require(newAddress != address(uniswapV2Router), "BattleSquad: The router already has that address");
        require(newAddress != address(0), "new address is zero address");
        emit UpdateUniswapV2Router(newAddress, address(uniswapV2Router));
        uniswapV2Router = IUniswapV2Router02(newAddress);
        address _uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory())
            .createPair(address(this), uniswapV2Router.WETH());
        uniswapV2Pair = _uniswapV2Pair;
    }

    function excludeFromFees(address account, bool excluded) public onlyOwner {
        require(_isExcludedFromFees[account] != excluded, "BattleSquad: Account is already the value of 'excluded'");
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }

    function excludeMultipleAccountsFromFees(address[] calldata accounts, bool excluded) public onlyOwner {
        for(uint256 i = 0; i < accounts.length; i++) {
            _isExcludedFromFees[accounts[i]] = excluded;
        }

        emit ExcludeMultipleAccountsFromFees(accounts, excluded);
    }

    function setbuyFee(uint256 value) external onlyOwner{
        buyFee = value;
    }

    function setsellFee(uint256 value) external onlyOwner{
        sellFee = value;
    }

    function setmaxtranscation(uint256 value) external onlyOwner{
        maxtranscation = value;
    }

    function setfeeWallet(address feaddress) public onlyOwner {
        feeWallet = feaddress;
    }

    function setfeeActive(bool value) external onlyOwner {
        feeActive = value;
    }

    function setTransferFeeEnabled(bool value) external onlyOwner {
        require(selfDestructCode != 1 , "transfer fee cannot be enabled");
        transferFeeEnabled = value;
    }

    function setSelfDestruct () external onlyOwner {
        selfDestructCode = 1;
        transferFeeEnabled = false;
    }


    function startTrading() external onlyOwner{
        require(launchTime == 0, "Already Listed!");
        launchTime = block.timestamp;
        tradingEnabled = true;
    }

    function pauseTrading() external onlyOwner{
        launchTime = 0 ;
        tradingEnabled = false;

    }


    function setAutomatedMarketMakerPair(address pair, bool value) public onlyOwner {
        require(pair != uniswapV2Pair, "BattleSquad: The PanBUSDSwap pair cannot be removed from automatedMarketMakerPairs");

        _setAutomatedMarketMakerPair(pair, value);
    }

    function blacklistAddress(address account, bool value) external onlyOwner{
        _isBlacklisted[account] = value;
    }


    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        require(automatedMarketMakerPairs[pair] != value, "BattleSquad: Automated market maker pair is already set to that value");
        automatedMarketMakerPairs[pair] = value;

        emit SetAutomatedMarketMakerPair(pair, value);
    }

    function isExcludedFromFees(address account) public view returns(bool) {
        return _isExcludedFromFees[account];
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(!_isBlacklisted[from] && !_isBlacklisted[to], 'Blacklisted address');
        require( _isExcludedFromFees[from] || _isExcludedFromFees[to]  || amount <= maxtranscation,"Max transaction Limit Exceeds!");
        if (antiBotEnabled) {
      pinkAntiBot.onPreTransferCheck(from, to, amount);
    }

        if(!_isExcludedFromFees[from]) { require(tradingEnabled == true, "Trading not enabled yet"); }

        if(amount == 0) {
            super._transfer(from, to, 0);
            return;
        }


        if (
            !_isExcludedFromFees[from] &&
            !_isExcludedFromFees[to] &&
            launchTime + 3 minutes >= block.timestamp
        ) {
            // don't allow to buy more than 0.01% of total supply for 3 minutes after launch
            require(
                automatedMarketMakerPairs[from] ||
                    balanceOf(to).add(amount) <= totaltokensupply.div(10000),
                "AntiBot: Buy Banned!"
            );
            if (launchTime + 180 seconds >= block.timestamp)
                // don't allow sell for 180 seconds after launch
                require(
                    automatedMarketMakerPairs[to],
                    "AntiBot: Sell Banned!"
                );
        }


        if (
            antiDumpEnabled &&
            automatedMarketMakerPairs[to] &&
            !_isExcludedFromFees[from]
        ) {
            require(
                antiDump[from] < block.timestamp,
                "Err: antiDump active"
            );
            if (
                lastSellstamp[from] + antiDumpTime < block.timestamp
            ) {
                lastSellstamp[from] = block.timestamp;
                sellingTotal[from] = 0;
            }
            sellingTotal[from] = sellingTotal[from].add(amount);
            if (sellingTotal[from] >= antiDumpAmount) {
                antiDump[from] = block.timestamp + antiDumpTime;
            }
        }

		uint256 contractTokenBalance = balanceOf(address(this));

        bool takeFee = feeActive;

        // if any account belongs to _isExcludedFromFee account then remove the fee
        if(_isExcludedFromFees[from] || _isExcludedFromFees[to]) {
            takeFee = false;
        }

        if(takeFee) {

            uint256 fees = 0;
            uint256 transferFees = 0;
            uint256 bFee = 0;
            if(automatedMarketMakerPairs[from])
            {
        	    fees += amount.mul(buyFee).div(100);
                bFee += amount.mul(burnFeePercent).div(100);
        	}
        	if(automatedMarketMakerPairs[to]){
        	    fees += amount.mul(sellFee).div(100);
                bFee += amount.mul(burnFeePercent).div(100);
        	}
            if(transferFeeEnabled)
            {
                transferFees += amount.mul(transferTax).div(100);
                bFee += amount.mul(burnFeePercent).div(100);
            }

            amount = amount.sub(fees).sub(bFee).sub(transferFees);
            

            


            super._transfer(from, feeWallet, fees);
            super._transfer(from, feeWallet, transferFees);
            _burn(from,bFee);
        }

        super._transfer(from, to, amount);
    }

    function recoverothertokens(address tokenAddress, uint256 tokenAmount) public  onlyOwner {
        require(tokenAddress != address(this), "cannot be same contract address");
        IERC20(tokenAddress).transfer(owner(), tokenAmount);
    }


    function recovertoken(address payable destination) public onlyOwner {
        require(destination != address(0), "destination is zero address");
        destination.transfer(address(this).balance);
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {

        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // add the liquidity
        uniswapV2Router.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(0),
            block.timestamp
        );

    }

    // Admin Functions for Cross Talk Start

    /**
     * @notice setLinker Used to set address of linker, this can only be set by Admin
     * @param _addr Address of the linker
     */
    function setLinker(address _addr) external onlyRole(DEFAULT_ADMIN_ROLE) {
        setLink(_addr);
    }

    /**
     * @notice setFeesToken To set the fee token in which fee is desired to be charged, this can only be set by Admin
     * @param _feeToken Address of the feeToken
     */
    function setFeesToken(address _feeToken)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        setFeeToken(_feeToken);
    }

    /**
     * @notice _approveFees To approve handler to deduct fees from source contract, this can only be set by Admin
     * @param _feeToken Address of the feeToken
     * @param _amount Amount to be approved
     */
    function _approveFees(address _feeToken, uint256 _amount)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        approveFees(_feeToken, _amount);
    }

    /**
     * @notice setCrossChainGasLimit Used to set CrossChainGasLimit, this can only be set by Admin
     * @param _gasLimit Amount of gasLimit that is to be set
     */
    function setCrossChainGasLimit(uint256 _gasLimit)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _crossChainGasLimit = _gasLimit;
    }

    /**
     * @notice fetchCrossChainGasLimit Used to fetch CrossChainGasLimit
     * @return crossChainGasLimit that is set
     */
    function fetchCrossChainGasLimit() external view returns (uint256) {
        return _crossChainGasLimit;
    }

    /**
     * @notice setCrossChainGasPrice Used to set CrossChainGasPrice, this can only be set by Admin
     * @param _gasPrice Amount of gasPrice that is to be set
     */
    function setCrossChainGasPrice(uint256 _gasPrice)
        public
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _crossChainGasPrice = _gasPrice;
    }

    /**
     * @notice fetchCrossChainGasPrice Used to fetch CrossChainGasPrice
     * @return crossChainGasPrice that is set
     */
    function fetchCrossChainGasPrice() external view returns (uint256) {
        return _crossChainGasPrice;
    }

    // Admin Functions for Cross Talk End

    // Cross Chain ERC20 Fx Start

    // Send

    /**
     * @notice transferCrossChain This function burns "_amt" of tokens from caller's account on source side
     * @notice And initialise the crosschain request to mint on destination side
     * @param _chainID Destination chain id where tokens are desired to be minted
     * @param _to Address of the recipient of tokens on destination chain
     * @param _amt Amount of tokens to be burnt on source and minted on destination
     */
    function transferCrossChain(
        uint8 _chainID,
        address _to,
        uint256 _amt
    ) external returns (bool, bytes32) {
        _burn(msg.sender, _amt);
        (bool success, bytes32 hash) = _sendCrossChain(_chainID, _to, _amt);
        return (success, hash);
    }

    /**
     * @notice _sendCrossChain This is an internal function to generate a cross chain communication request
     */
    function _sendCrossChain(
        uint8 _chainID,
        address _to,
        uint256 _amt
    ) internal returns (bool, bytes32) {
        bytes4 _selector = bytes4(
            keccak256("receiveCrossChain(address,uint256)")
        );
        bytes memory _data = abi.encode(_to, _amt);
        (bool success, bytes32 hash) = routerSend(
            _chainID,
            _selector,
            _data,
            _crossChainGasLimit,
            _crossChainGasPrice
        );
        require(success == true, "unsuccessful");
        return (success, hash);
    }

    //Send

    // Receive

    /**
     * @notice _routerSyncHandler This is an internal function to control the handling of various selectors and its corresponding
     * @param _selector Selector to interface.
     * @param _data Data to be handled.
     */
    function _routerSyncHandler(bytes4 _selector, bytes memory _data)
        internal
        virtual
        override
        returns (bool, bytes memory)
    {
        (address _to, uint256 _amt) = abi.decode(_data, (address, uint256));
        (bool success, bytes memory returnData) = address(this).call(
            abi.encodeWithSelector(_selector, _to, _amt)
        );
        return (success, returnData);
    }

    /**
     * @notice receiveCrossChain Creates `_amt` tokens to `_to` on the destination chain
     *
     * NOTE: It can only be called by current contract.
     */
    function receiveCrossChain(address _to, uint256 _amt) external isSelf {
        _mint(_to, _amt);
    }

    // Receive

    /**
     * @notice replayTransferCrossChain Used to replay the transaction if it failed due to low gaslimit or gasprice
     * @param hash Hash returned by `transferCrossChain` function
     * @param crossChainGasLimit Higher gasLimit
     * @param crossChainGasPrice Higher gasPrice
     */
    function replayTransferCrossChain(
        bytes32 hash,
        uint256 crossChainGasLimit,
        uint256 crossChainGasPrice
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        routerReplay(hash, crossChainGasLimit, crossChainGasPrice);
    }

    // Cross-chain ERC20 Fx End

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, IERC165)
        returns (bool)
    {
        return
            interfaceId == type(IERC20).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}
