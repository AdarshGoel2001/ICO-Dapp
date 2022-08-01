//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  import "./ICryptoDevs.sol";

contract CryptoDevTokens is ERC20, Ownable {

    ICryptoDevs CryptoDevsNFT;

    uint256 public constant tokensPerNFT = 10 * (10**18);
    uint256 public constant tokenPrice = 0.001 ether;
    uint256 public constant maxTotalSupply = 10000 * 10**18;

    mapping (uint256 => bool) public tokenIdsClaimed;

    constructor (address _cryptoDecaContract) ERC20 ("CryptoDev Token", "CDT"){
   CryptoDevsNFT = ICryptoDevs (_cryptoDecaContract);

    }

    function claim () public {
        uint256 balance = CryptoDevsNFT.balanceOf(msg.sender);
        require(balance >0 , "You dont own any Crypto Dev NFTs"); 
        uint amount;
        for (uint i = 0; i<balance ; i++){
            uint256 tokenId = CryptoDevsNFT.tokenOfOwnerByIndex (msg.sender , i);

            if (!tokenIdsClaimed[tokenId]){
                tokenIdsClaimed[tokenId] = true;
                amount++;
            }
            
        }
        require(amount>0, "You have claimed all your tokens per NFT");

        _mint(msg.sender, amount * tokensPerNFT );
    }

    function mint  (uint256 amount) public payable {
        uint256 _requiredAmount = tokenPrice*amount;
        require(msg.value>= _requiredAmount, "Ether sent is incorrect");
        uint256 amountWithDecimals = 10**18 * amount;
        require(totalSupply() + amountWithDecimals <= maxTotalSupply, "Exceeds the max total supply available");
      _mint(msg.sender, amountWithDecimals );
    }
receive () external payable{}
fallback () external payable {}
}