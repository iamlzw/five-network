#!/bin/sh

#export env
export PATH=$GOPATH/src/github.com/hyperledger/fabric-samples/bin:$PATH
export FABRIC_CFG_PATH=$GOPATH/src/github.com/hyperledger/fabric-samples/config/

export CORE_PEER_TLS_ENABLED=true

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051


#create channel
peer channel create -o orderer.example.com:7050 -c mychannel -f channel-artifacts/channel.tx --tls --cafile $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

#peer0.org1 join channel
peer channel join -b mychannel.block

# export peer0.org2 env
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051
peer channel join -b mychannel.block

# export peer0.org3 env
export CORE_PEER_LOCALMSPID="Org3MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
export CORE_PEER_ADDRESS=peer0.org3.example.com:11051
peer channel join -b mychannel.block

# export peer0.org4 env
export CORE_PEER_LOCALMSPID="Org4MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp
export CORE_PEER_ADDRESS=peer0.org4.example.com:13051

peer channel join -b mychannel.block

# export peer0.org5 env
export CORE_PEER_LOCALMSPID="Org5MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
export CORE_PEER_ADDRESS=peer0.org5.example.com:15051
peer channel join -b mychannel.block

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

#install chaincode on peer0.org1,for go chaincode -p takes the relative path from $GOPATH/src,so you need copy chaincode to $GOPATH/src
peer chaincode install -n mycc -v 1.0 -p chaincode/chaincode_example02/go/

# export peer0.org2 env
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051
peer chaincode install -n mycc -v 1.0 -p chaincode/chaincode_example02/go/

# export peer0.org3 env
export CORE_PEER_LOCALMSPID="Org3MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
export CORE_PEER_ADDRESS=peer0.org3.example.com:11051
peer chaincode install -n mycc -v 1.0 -p chaincode/chaincode_example02/go/

# export peer0.org4 env
export CORE_PEER_LOCALMSPID="Org4MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp
export CORE_PEER_ADDRESS=peer0.org4.example.com:13051
peer chaincode install -n mycc -v 1.0 -p chaincode/chaincode_example02/go/

# export peer0.org5 env
export CORE_PEER_LOCALMSPID="Org5MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
export CORE_PEER_ADDRESS=peer0.org5.example.com:15051
peer chaincode install -n mycc -v 1.0 -p chaincode/chaincode_example02/go/

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

#instantiate chaincode on peer0.org1
peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -v 1.0 -c '{"Args":["init","a", "100", "b","200"]}' -P "AND ('Org1MSP.peer','Org2MSP.peer')"

sleep 1m
peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

# export peer0.org5 env
export CORE_PEER_LOCALMSPID="Org5MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
export CORE_PEER_ADDRESS=peer0.org5.example.com:15051
sleep 1m
peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'


peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0.org2.example.com:9051 --tlsRootCertFiles $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"Args":["invoke","a","b","2"]}'

peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'






