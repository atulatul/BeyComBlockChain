pragma solidity ^0.4.23;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

contract StarNotary is ERC721 { 

    struct Star { 
        string name;
        string Dec;
        string Mag;
        string Ra;
        string starStory; 
    }

    mapping(uint256 => Star) public tokenIdToStarInfo; 
    mapping(uint256 => uint256) public starsForSale;

    uint256[] userTokenIndex;
    uint256[]  auxUserToekIndex;

    function createStar(string _name,string _Dec, string _Mag, string _ra,string _story, uint256 _tokenId) public returns (string) { 
        
        require(!checkIfStarExist(_Dec,_Mag,_ra)); //check if star does not exist

        Star memory newStar = Star(_name,_Dec,_Mag,_ra,_story);

        tokenIdToStarInfo[_tokenId] = newStar;

        userTokenIndex.push(_tokenId); //update to iterate 

        _mint(msg.sender, _tokenId);
        return _name;
    }

    function putStarUpForSale(uint256 _tokenId, uint256 _price) public { 
        require(this.ownerOf(_tokenId) == msg.sender);

        starsForSale[_tokenId] = _price;
    }

    function buyStar(uint256 _tokenId) public payable { 
        require(starsForSale[_tokenId] > 0);
        
        uint256 starCost = starsForSale[_tokenId];
        address starOwner = this.ownerOf(_tokenId);
        require(msg.value >= starCost);

        _removeTokenFrom(starOwner, _tokenId);
        _addTokenTo(msg.sender, _tokenId);
        
        starOwner.transfer(starCost);

        if(msg.value > starCost) { 
            msg.sender.transfer(msg.value - starCost);
        }
    }

    function checkIfStarExist(string _dec, string _mag, string _ra) public view returns (bool){

        for (uint i = 0; i < userTokenIndex.length; i++) {
            
            if(keccak256(abi.encodePacked(tokenIdToStarInfo[userTokenIndex[i]].Dec))==keccak256(abi.encodePacked(_dec))){

                if(keccak256(abi.encodePacked(tokenIdToStarInfo[userTokenIndex[i]].Mag))==keccak256(abi.encodePacked(_mag)) ){

                    if(keccak256(abi.encodePacked(tokenIdToStarInfo[userTokenIndex[i]].Ra))==keccak256(abi.encodePacked(_ra)))
                    return true;
                }
            }    
    }
    return false;
    }

    function tokenIdToStarInfo(uint256 _tokenId) public view returns (string ) {

        for(uint i=0; i<userTokenIndex.length; ++i){

            if(_tokenId == userTokenIndex[i]){

                string memory strName = strConcat('[','"',tokenIdToStarInfo[userTokenIndex[i]].name,'"',", ");

                string memory strStory =strConcat('"',tokenIdToStarInfo[userTokenIndex[i]].starStory,'"',", ","");

                string memory str_ra =strConcat('"',"ra_",tokenIdToStarInfo[userTokenIndex[i]].Ra,'"',", ");

                string memory str_dec =strConcat('"',"dec_",tokenIdToStarInfo[userTokenIndex[i]].Dec,'"',", ");

                string memory str_mag =strConcat('"',"mag_",tokenIdToStarInfo[userTokenIndex[i]].Mag,'"',']');
                return strConcat(strName,strStory,str_ra,str_dec,str_mag);
            }
        }
        return " "; //loop finished no match so return null;
    }

    function strConcat(string _a, string _b, string _c, string _d, string _e) pure internal returns (string){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory _bd = bytes(_d);
        bytes memory _be = bytes(_e);

        string memory abcd = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length );
        bytes memory babcd = bytes(abcd);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcd[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babcd[k++] = _bb[i];
        for (i = 0; i < _bc.length; i++) babcd[k++] = _bc[i];
        for (i = 0; i < _bd.length; i++) babcd[k++] = _bd[i];
        for (i = 0; i < _be.length; i++) babcd[k++] = _be[i];

        return string(babcd);
}


}