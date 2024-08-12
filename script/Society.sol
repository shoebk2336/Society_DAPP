// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract Society {

    address public Manager;

    constructor(){
        Manager=msg.sender;
    }
        
    struct DevArea{
        string Title;
        address PaymentADD;
        uint VoteCount;
    }

    DevArea [] public  ArrDevAreas;

    struct FlatOwner{           //This is for Flat owner
        string Name;
        string FlatNo;
        address PaymentADD;
        uint Contribution;
        bool isOwned;
        }

       // FlatOwner [] public  ArrofFlatOwner;------------>This id for first method to store object in array
        mapping (string  => FlatOwner) public FlatOwners;


        function ListDevArea (string memory Title,address PaymentADD) public returns (string memory) {
            require(
                msg.sender==Manager,"Kindly Login with Manager Account"
            );
            for(uint i=0;i<ArrDevAreas.length;i=i+1){
                if(keccak256(abi.encodePacked(ArrDevAreas[i].Title))==keccak256(abi.encodePacked(Title)) && ArrDevAreas[i].PaymentADD==PaymentADD){
                    return ("This Area is already listed");
                }              
            }
            ArrDevAreas.push(DevArea(Title,PaymentADD,VoteCount=0));
                    return ("Area of Devlopment Added Successfully");

        }

        function Contribute(string memory Name,string memory FlatNo ) payable public {
            address PaymentADD=msg.sender;
            uint Contribution=msg.value;
//--------------------------------------------------------------------------------------------
//==>There are two ways to add object/struct into array this below is first we used to do in
//JS create an object and push it to array
//Here the index is start from 0 to n as we push and its iterable like we did using for loop

            // for(uint i=0;i<ArrofFlatOwner.length;i++){
            //     if(keccak256(abi.encodePacked((ArrofFlatOwner[i].FlatNo)))==keccak256(abi.encodePacked(FlatNo))){
            //         ArrofFlatOwner[i].Contribution=ArrofFlatOwner[i].Contribution+msg.value;
            //         ArrofFlatOwner[i].PaymentADD=msg.sender;
            //     }
            // }

            // ArrofFlatOwner.push(FlatOwner(Name,FlatNo,PaymentADD,Contribution));

//--------------------------------------------------------------------------------------------
//This second method of adding object/struct into an array using map
//Here we add the object into arr and the index is our choice 
//so we used index as FlatNo so we can easily check whether  FlatNo contributed or not if yes then we can 
//sum up there contribution and also update the address

            if(FlatOwners[FlatNo].isOwned){
                uint UpdatedContribution=FlatOwners[FlatNo].Contribution+Contribution;
                FlatOwners[FlatNo]=FlatOwner(Name,FlatNo,PaymentADD,UpdatedContribution,true);
            }
            else
                FlatOwners[FlatNo]=FlatOwner(Name,FlatNo,PaymentADD,Contribution,true);
            
            //return(FlatOwners);===>Here we trying to print all the obj in array but not possible
            //beacuse we use mapping so we only print specific object by entering its key
        }

    
}