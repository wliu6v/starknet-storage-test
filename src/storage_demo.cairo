use starknet::ContractAddress;

#[contract]
mod StorageDemo {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use option::OptionTrait;
    use array::SpanTrait;
    use traits::Into;
    use hello_starknet::felt_obj::FeltObj;
    use hello_starknet::nofelt_obj::NoFeltObj;
    use hello_starknet::felt_nou8_obj::FeltNou8Obj;
    use array::ArrayTrait;

    struct Storage {
        admin: ContractAddress,
        // TestA : with felt attr
        feltObj: FeltObj,
        feltObjMap: LegacyMap<u32, FeltObj>,
        // TestB: no felt attr
        nofeltObj: NoFeltObj,
        nofeltObjMap: LegacyMap<u32, NoFeltObj>,
        // TestC: felt but no u8 
        feltNou8Obj: FeltNou8Obj,
        feltNou8ObjMap: LegacyMap<u32, FeltNou8Obj>,
    }

    #[constructor]
    fn constructor(_admin: ContractAddress) {
        admin::write(_admin);
        let tempObj1 = FeltObj { id: 1, url1: '123', url2: '456', sum: 4 };
        feltObj::write(tempObj1);
        feltObjMap::write(1, tempObj1);

        let tempObj2 = NoFeltObj { id: 1, sum: 4 };
        nofeltObj::write(tempObj2);
        nofeltObjMap::write(1, tempObj2);

        let tempObj3 = FeltNou8Obj { id: 1, url1: '123', url2: '456', sum: 4 };
        feltNou8Obj::write(tempObj3);
        feltNou8ObjMap::write(1, tempObj3);
    }

    #[view]
    fn name() -> felt252 {
        'GovNft'
    }

    fn feltObjToArray(obj: FeltObj) -> Array<felt252> {
        let mut result = ArrayTrait::<felt252>::new();

        result.append(obj.id.into());
        result.append(obj.url1);
        result.append(obj.url2);
        result.append(obj.sum.into());

        result
    }

    fn feltNou8ObjToArray(obj: FeltNou8Obj) -> Array<felt252> {
        let mut result = ArrayTrait::<felt252>::new();

        result.append(obj.id.into());
        result.append(obj.url1);
        result.append(obj.url2);
        result.append(obj.sum.into());

        result
    }

    fn nofeltObjToArray(obj: NoFeltObj) -> Array<felt252> {
        let mut result = ArrayTrait::<felt252>::new();

        result.append(obj.id.into());
        result.append(obj.sum.into());

        result
    }

    #[view]
    fn getFeltObj() -> Array<felt252> {
        let obj: FeltObj = feltObj::read();
        feltObjToArray(obj)
    }

    #[view]
    fn getFeltObjFromMap(id: u32) -> Array<felt252> {
        let obj: FeltObj = feltObjMap::read(id);
        feltObjToArray(obj)
    }

    #[external]
    fn saveFeltObj(id: u32) -> Array<felt252> {
        let tempObj = FeltObj { id: id, url1: 'aaa', url2: 'bbb', sum: 3 };
        feltObjMap::write(id, tempObj);
        feltObj::write(tempObj);
        feltObjToArray(tempObj)
    }


    #[view]
    fn getNoFeltObj() -> Array<felt252> {
        let obj: NoFeltObj = nofeltObj::read();
        nofeltObjToArray(obj)
    }

    #[view]
    fn getNoFeltObjFromMap(id: u32) -> Array<felt252> {
        let obj: NoFeltObj = nofeltObjMap::read(id);
        nofeltObjToArray(obj)
    }

    #[external]
    fn saveObj(id: u32) -> Array<felt252> {
        let tempObj = NoFeltObj { id: id, sum: 3 };
        nofeltObjMap::write(id, tempObj);
        nofeltObj::write(tempObj);
        nofeltObjToArray(tempObj)
    }

    #[view]
    fn getFeltNou8Obj() -> Array<felt252> {
        let obj: FeltNou8Obj = feltNou8Obj::read();
        feltNou8ObjToArray(obj)
    }

    #[view]
    fn getFeltNou8ObjFromMap(id: u32) -> Array<felt252> {
        let obj: FeltNou8Obj = feltNou8ObjMap::read(id);
        feltNou8ObjToArray(obj)
    }

    #[external]
    fn saveFeltNou8Obj(id: u32) -> Array<felt252> {
        let tempObj = FeltNou8Obj { id: id, url1: 'aaa', url2: 'bbb', sum: 3 };
        feltNou8ObjMap::write(id, tempObj);
        feltNou8Obj::write(tempObj);
        feltNou8ObjToArray(tempObj)
    }
}
