pragma ton-solidity >= 0.53.0;

import "./IServiceDiscovery.sol";

abstract contract ServiceDiscoveryClient {
    private optinal(address) addr;

    function setAddress(address _addr) external {
        tvm.accept();
        addr = _addr;
    }

    function find(string[] tags) public returns(address[]) {
        return IServiceDiscovery(addr).find(tags);
    }

    function all() public returns(Service[]) {
        return IServiceDiscovery(addr).all();
    }
}