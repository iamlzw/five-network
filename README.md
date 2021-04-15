# five-network
reference https://hyperledger-fabric.readthedocs.io/en/release-1.4/build_network.html

You need to perform these steps manually,because the script is not applicable.

this tutorials was base fabric v1.4.2,but I think it also applies to v2.x.

and I have put to git reposistory https://github.com/iamlzw/byfn-with-five-org.git

you need to clone this reposistory to $GOPATH/src/github.com/hyperledger/fabric-samples/

1、Configure configtx.yaml
you need configure Organizations: and Profiles:，how many organizations you want join in network,then you need to configure how many organizations

reference https://github.com/iamlzw/byfn-with-five-org/blob/master/configtx.yaml

2、Configure crypto-config.yaml
you need configure PeerOrgs:,same as above,how many organizations you want join in network,then you need to configure how many organizations.

referene https://github.com/iamlzw/byfn-with-five-org/blob/master/crypto-config.yaml

3、Manually generate the artifacts
generate crypto artifacts
```
cd $GOPATH/src/github.com/hyperledger/fabric-samples/five-network
../bin/cryptogen generate --config=./crypto-config.yaml
```
generate orderer genesis block
```
export FABRIC_CFG_PATH=$PWD
../bin/configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
```
4、Create a Channel Configuration Transaction
```
export CHANNEL_NAME=mychannel  && ../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
```
5、Start the network
```
docker-compose -f docker-compose-e2e.yaml up -d
```
5.1 create and join channel

execute this command in your terminal not in cli container, because I dont start a cli container

so you need configure your /etc/hosts

sudo /etc/hosts
```
### add these content
127.0.0.1 orderer.example.com
127.0.0.1 peer0.org1.example.com 
127.0.0.1 peer1.org1.example.com
127.0.0.1 peer0.org2.example.com
127.0.0.1 peer1.org2.example.com
127.0.0.1 peer0.org3.example.com 
127.0.0.1 peer1.org3.example.com
127.0.0.1 peer0.org4.example.com
127.0.0.1 peer1.org4.example.com
127.0.0.1 peer0.org5.example.com
127.0.0.1 peer1.org5.example.com
```

next all steps will get same result as execute script ```byfn_five.sh```

5.1.1 create genesis block
```
### export peer0.org1.example.com env

export PATH=$GOPATH/src/github.com/hyperledger/fabric-samples/bin:$PATH
export FABRIC_CFG_PATH=$GOPATH/src/github.com/hyperledger/fabric-samples/config/

export CORE_PEER_TLS_ENABLED=true

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

#### create channel genesis block

peer channel create -o orderer.example.com:7050 -c mychannel -f channel-artifacts/channel.tx --tls --cafile $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

#### join channel

peer channel join -b mychannel.block

#### export another peer env and join in channel

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

5.1.2 install chaincode

#install chaincode on peer0.org1
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
peer chaincode install -n mycc -v 1.0 -p chaincode/chaincode_example02/go/

#### export another peer env and install chaincode

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
5.1.3 instantiate chaincode,you need just instantiate chaincode on peer0.org1

#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

#instantiate chaincode on peer0.org1
peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -v 1.0 -c '{"Args":["init","a", "100", "b","200"]}' -P "AND ('Org1MSP.peer','Org2MSP.peer')"
```
6、invoke and query
```
#export peer0.org1 env
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

# export peer0.org5 env
export CORE_PEER_LOCALMSPID="Org5MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
export CORE_PEER_ADDRESS=peer0.org5.example.com:15051

peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

### invoke use peer0.org5
peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0.org2.example.com:9051 --tlsRootCertFiles $GOPATH/src/github.com/hyperledger/fabric-samples/five-network/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"Args":["invoke","a","b","2"]}'

### query
peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
```


