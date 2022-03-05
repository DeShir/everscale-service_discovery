pragma ton-solidity >= 0.53.0;

import "./IServiceDiscovery.sol";

abstract contract ServiceDiscoveryClient {
    optional(address) private addr;

    function setAddress(address _addr) external {
        tvm.accept();
        addr = _addr;
    }

    function find(string[] tags) public {
        require(addr.hasValue(), 100);
        optional(uint256) none;
        return IServiceDiscovery(addr.get()).find{
            sign: false,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(findCallback),
            onErrorId: 0
        }(tags).extMsg;
    }

    function findCallback(address[] addrs) public virtual;

    function all() public {
        require(addr.hasValue(), 100);
        optional(uint256) none;
        return IServiceDiscovery(addr.get()).all{
            sign: false,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(allCallback),
            onErrorId: 0
        }().extMsg;
    }

    function allCallback(IServiceDiscovery.Service[] services) public virtual;
}
