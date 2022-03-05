pragma ton-solidity >= 0.53.0;

library StringArrays {

    function hasAny(string[] items1, string[] items2) public returns(bool) {
        int index = int(items2.length);
        while(--index >= 0 && indexOf(items1, items2[uint(index)]) == -1) {}

        return index != -1;
    }

    function indexOf(string[] items, string item) public returns(int) {
        int index = int(items.length);
        while(--index >= 0 && items[uint(index)] != item) {}

        return index;
    }
}
