use starknet::StorageAccess;
use starknet::SyscallResult;
use starknet::StorageBaseAddress;
use starknet::ContractAddress;
use array::ArrayTrait;

#[derive(Copy, Drop, storage_access::StorageAccess)]
struct FeltNou8Obj {
    id: u32,
    sum: u32,
    url1: felt252,
    url2: felt252,
}

impl StorageAccessProposal of StorageAccess<FeltNou8Obj> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<FeltNou8Obj> {
        Result::Ok(
            FeltNou8Obj {
                id: StorageAccess::<u32>::read(address_domain, base)?,
                sum: StorageAccess::<u32>::read(address_domain, base)?,
                url1: StorageAccess::<felt252>::read(address_domain, base)?,
                url2: StorageAccess::<felt252>::read(address_domain, base)?,
            }
        )
    }

    #[inline(always)]
    fn write(address_domain: u32, base: StorageBaseAddress, value: FeltNou8Obj) -> SyscallResult<()> {
        StorageAccess::<u32>::write(address_domain, base, value.id)?;
        StorageAccess::<u32>::write(address_domain, base, value.sum)?;
        StorageAccess::<felt252>::write(address_domain, base, value.url1)?;
        StorageAccess::<felt252>::write(address_domain, base, value.url2)
    }
}
