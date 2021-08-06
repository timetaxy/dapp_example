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
