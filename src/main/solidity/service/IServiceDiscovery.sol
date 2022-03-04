pragma ton-solidity >= 0.53.0;

interface IServiceDiscovery {
    struct Service {
        address addr;
        string[] tags;
    }
    function add(Service item) external;
    function remove(address addr) external;
    function find(string[] tags) external view returns(address[]);
    function all() external view returns(Service[]);
}
