pragma ton-solidity >= 0.53.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

import "../IServiceDiscovery.sol";
import "../../utils/Arrays.sol";

abstract contract ServiceDiscoveryImpl is IServiceDiscovery {

    using StringArrays for string[];

    Service[] private services;

    function add(Service service) external override {
        tvm.accept();
        services.push(service);
    }

    function remove(address addr) external override {
        tvm.accept();
        int index = int(services.length);
        while(--index >= 0 && services[uint(index)].addr != addr) {}

        if(index >= 0) {
            services[uint(index)] = services[services.length - 1];
            services.pop();
        }
    }

    function find(string[] tags) external override view returns(address[]) {
        address[] addresses;

        for(Service service : services) {
            if(service.tags.hasAny(tags)) {
                addresses.push(service.addr);
            }
        }

        return addresses;
    }

    function all() external override view returns(Service[]) {
        return services;
    }
}