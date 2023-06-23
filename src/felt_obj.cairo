use starknet::StorageAccess;
use starknet::SyscallResult;
use starknet::StorageBaseAddress;
use starknet::ContractAddress;
use array::ArrayTrait;

#[derive(Copy, Drop, storage_access::StorageAccess)]
struct FeltObj {
    id: u32,
    sum: u8,
    url1: felt252,
    url2: felt252,
}

impl StorageAccessProposal of StorageAccess<FeltObj> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<FeltObj> {
        Result::Ok(
            FeltObj {
                id: StorageAccess::<u32>::read(address_domain, base)?,
                sum: StorageAccess::<u8>::read(address_domain, base)?,
                url1: StorageAccess::<felt252>::read(address_domain, base)?,
                url2: StorageAccess::<felt252>::read(address_domain, base)?,
            }
        )
    }

    #[inline(always)]
    fn write(address_domain: u32, base: StorageBaseAddress, value: FeltObj) -> SyscallResult<()> {
        StorageAccess::<u32>::write(address_domain, base, value.id)?;
        StorageAccess::<u8>::write(address_domain, base, value.sum)?;
        StorageAccess::<felt252>::write(address_domain, base, value.url1)?;
        StorageAccess::<felt252>::write(address_domain, base, value.url2)
    }
}
