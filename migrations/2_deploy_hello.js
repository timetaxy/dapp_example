const helloWorld = artifacts.require("HelloWorld");
//require은 파일명이 아니라 컨트랙트명
module.exports = function(deployer){
    // deployer.deploy(helloWorld, "Hello!", 1,2,3) //args 복수일 경우
    deployer.deploy(helloWorld, "Hello!")
}