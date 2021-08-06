#inflearn 블록체인 Dapp 개발에 트러플 활용하기_기본편

트러플 자동화도구(컴파일테스트배포)
가나쉬 로컬 가상 이더리움

trufflesuite.com/docs
web3js.readthedocs.io/
solidity.readthedocs.io

node -v
npm i -g truffle
truffle version
	솔리디티 버전 확인
truffle init

ide 플러그인 설치
truffle-config 컴파일러 버전 선택가능, 버전 명시, 주석해제
     // Configure your compilers
  compilers: {
    solc: {

truffle compile
truffle compile --all

컴파일하면 byte코드-블록체인에 배포, abi 생성
contract_build_directory로 컴파일 디렉토리 변경 가능
    기본 build/contracts

q. how ganache workspace cli

설정 automine tx발생때마다 마이닝
migrations 하위 배포스크립트
배포스크립트에 이름은 컨트랙트이름
배포타겟 트러플컨픽 networks 필드

배포스크립트 직접 작성, ./contracts
//ref: https://medium.com/coinmonks/5-minute-guide-to-deploying-smart-contracts-with-truffle-and-ropsten-b3e30d5ee1e

truffle migrate --network development
    network옵션 미기입시 로컬
truffle migrate --reset

네트워크 배포시 지갑 설정 필요
npm i truffle-hdwallet-provider

외부배포시 내부적으로 dryrun 진행됨
truffle networks
truffle console --network development
    truffle console --network ropsten

abi호출하기
let hello = await HelloWorld.at("0xBfaD9A9982B2169E124F754b2F8036bCEA542137")
hello.say()

truffle test

트러플 라이브러리
https://trufflesuite.com/boxes/index.html
mkdir react-dapp
cd react-dapp
truffle unbox react

출금js 스크립트 작성 후
exec /send)u.js

---
# todo this time
react-web3.js
npm i truffle-contract
npm i ethereumjs-tx

tx?:eoa의 pk로 서명 매서드 호출

react앱 경우 component did mount, get web3

트러플에서 컴파일한 아티팩트를 임포트
import SimpleStorage from './contracts/SimpleStorage'

npm run start
리액트 부트스트랩 사용 화면 구성

web3가져오기
componentDidMount
const web3 = await getWeb3();
const accounts = await web3.eth.getAccounts();
const networkId = await web3.eth.net.getId();
const deployedNetwork = SimpleStorage.networks[networkId];
const instance = new web3.eth.Contract(Simple)
this.setState({web3,accounts,networkId,contract:instance});
//이벤트를 기다림
instance.events.Change().on('data',(event)=>{this.handleEvent(event);}.on('error',(err)=>{console.log(err)}));
--
handleSend = async()=>{
    const {accounts, contract} = this.state;
    if(this.state.val>0){
        this.setState({pending:!this.state.pending});
        try{
            await contract.methods.set(this.state.val).send({from:accounts[0]});
        }catch(err){
            console.log(err.message);
            this.setState({pending:false});
        }
    }
}
--

<Button onClick={this.handleSend}>

--
트러플 컨트랙트 라이브러리 사용하기
const deployedNetwork = SimpleStorage.networks[networkId];
const instance = new web3.eth.Contract(Simple)
=>
const Contract = TruffleContract(SimpleStorage);
Contract.setProvider(web3.currentProvider);
const instance = await Contract.deployed();

web3 서브스크라이브로 리스닝, 웹소켓 일 때만 사용 가능
트랜잭션 로그 수신 가능
web3.eth.subscribe("logs",{address:instance.address}).on('data',(log)=>{
    this.handleLog(log);
}).on('error',(err)=>console.log(err));

handleLog=(log)=>{
    const {web3}=this.state;
    const params=[{type:'string',name:'message'},{type:'uint256',name:'newVal1'}]
    const returnValues = web3.eth.abi.decodeLog(params,log.data);
    this.setState({pending:!this.state.pending,storedData:returnValues.newVal});
}

--

참고 sendTransaction & sendRawTransaction
//https://stackoverflow.com/questions/50985798/difference-between-sendtransaction-and-sendrawtransaction-in-web3-py
w3.eth.sendTransaction() only supports sending unsigned transactions. In order to use it, your node must be managing your private key. Since the node must manage your key, you must not use it with a hosted node.

w3.eth.sendRawTransaction() requires that the transaction be already signed and serialized. So it requires extra serialization steps to use, but enables you to broadcast transactions on hosted nodes. There are other reasons that you might want to use a local key, of course. All of them would require using sendRawTransaction().

--
서명받지 않은 tx 서명하기
this.setState({pending:!this.state.pending});
const result = await axios.post('/eth/set',{from:accounts[0], val:this.state.val});
if(result!==undefined&&result.data!==undefined&&result.data.rawTx!==undefined){
    await web3.eth.sendTransaction(result.data.rawTx)
}
--
ethereumjs-tx 라이브러리 사인 부터 send까지 백엔드에서때 유용

const ethTx = require('ethreumjs-tx');
const data = contract.methods.set(val).encodeABI();
const txCount = await web3.eth.getTransactionCount(from);
const txObject = {
    nonce:we3.utils.toHex(txCount),
    from:from,
    to:address,
    data:data,
    gasLimit:web3.utils.toHex(3000000),
    gasPrice:web3.utils.toHex(web3.utils.toWei('20','gwei')),
}
const tx = new ethTx(txObject);
tx.sign(privateKey); // sign a transaction with a given private key(32bytes)
const serializedTx = ts.serialize();
const txHash = await web3.eth.sendSignedTransaction('0x),+serializedTx.toString('hex');