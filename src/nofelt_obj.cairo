use starknet::StorageAccess;
use starknet::SyscallResult;
use starknet::StorageBaseAddress;
use starknet::ContractAddress;
use array::ArrayTrait;

#[derive(Copy, Drop, storage_access::StorageAccess)]
struct NoFeltObj {
    id: u32,
    sum: u8,
}

impl StorageAccessProposal of StorageAccess<NoFeltObj> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<NoFeltObj> {
        Result::Ok(
            NoFeltObj {
                id: StorageAccess::<u32>::read(address_domain, base)?,
                sum: StorageAccess::<u8>::read(address_domain, base)?,
            }
        )
    }

    #[inline(always)]
    fn write(address_domain: u32, base: StorageBaseAddress, value: NoFeltObj) -> SyscallResult<()> {
        StorageAccess::<u32>::write(address_domain, base, value.id)?;
        StorageAccess::<u8>::write(address_domain, base, value.sum)
    }
}
