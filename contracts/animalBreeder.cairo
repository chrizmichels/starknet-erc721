%lang starknet
%builtins pedersen range_check ecdsa

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.cairo.common.uint256 import Uint256


#from starknet.cairo.math import addNum

from token.ERC721.ERC721_base import (
    ERC721_name,
    ERC721_symbol,
    ERC721_balanceOf,
    ERC721_ownerOf,
    ERC721_getApproved,
    ERC721_isApprovedForAll,
    ERC721_mint,
    ERC721_burn,
    ERC721_initializer,
    ERC721_approve,
    ERC721_setApprovalForAll,
    ERC721_transferFrom,
    ERC721_safeTransferFrom
)


from utils.Ownable_base import (
    Ownable_only_owner
)


#
# Storage
#


# I need an array to store token_id's and Animal charakteristics
struct MyAnimal:
    member sex_number: felt
    member wings_number: felt
    member legs_number: felt
end


@storage_var
func a_name() -> (name: felt):
end

@storage_var
func stored_rank() -> (rank: felt):
end

@storage_var
func stored_legs_number() -> (legs: felt):
end

@storage_var
func stored_sex_number() -> (sex: felt):
end

@storage_var
func stored_wings_number() -> (wings: felt):
end

@storage_var
func token_id_count() -> (num: felt):
end

@storage_var
func token_id_increment() -> (num: felt):
end

@storage_var
func my_animal(tokenid: Uint256) -> (animal: MyAnimal):
end

@storage_var
func token_id_value() -> (tokenIDVal: Uint256):
end



#
# Constructor
#

@constructor
func constructor{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(name: felt, symbol: felt, owner: felt):
    ERC721_initializer(name, symbol)
    let to = 3160224547644632651535279661899767678482086458911879210087695553296143624415 #1510851416778934944204297693229363058079533847382583980692826508708240175931
    let token_id: Uint256 = Uint256(1,0)
    ERC721_mint(to, token_id)
    saveTokenIdCount(42)
    saveTokenIdIncrement(1)
    return ()
end

#
# Getters
#


@view
func get_animal_characteristics{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    } (token_id: Uint256) -> (sex: felt, legs: felt, wings: felt) :
    alloc_locals

    let (animal) = read_animal(token_id)
    
    # Retrieve expected characteristics
    let sex = animal.sex_number
    let legs = animal.legs_number
    let wings = animal.wings_number    

    return (sex, legs, wings)
end

@view
func read_animal{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (animal: MyAnimal):
    let (animal) = my_animal.read(token_id)
    return (animal)
end

@view
func read_aa_name{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (name: felt):
    let (name) = a_name.read()
    return (name)
end


@view
func readTokenIDCount{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (num: felt):
    let (num) = token_id_count.read()
    return (num)
end

@view
func readTokenIDIncrement{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (num: felt):
    let (num) = token_id_increment.read()
    return (num)
end

@view
func readAssignedRank{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (rank: felt):
    let (rank) = stored_rank.read()
    return (rank)
end

@view
func readAssignedLegsNumber{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (legs: felt):
    let (legs) = stored_legs_number.read()
    return (legs)
end

@view
func readAssignedSexNumber{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (sex: felt):
    let (sex) = stored_sex_number.read()
    return (sex)
end

@view
func readAssignedWingsNumber{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (wings: felt):
    let (wings) = stored_wings_number.read()
    return (wings)
end

@view
func name{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (name: felt):
    let (name) = ERC721_name()
    return (name)
end

@view
func symbol{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (symbol: felt):
    let (symbol) = ERC721_symbol()
    return (symbol)
end

@view
func balanceOf{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(owner: felt) -> (balance: Uint256):
    let (balance: Uint256) = ERC721_balanceOf(owner)
    return (balance)
end

@view
func ownerOf{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (owner: felt):
    let (owner: felt) = ERC721_ownerOf(token_id)
    return (owner)
end

@view
func getApproved{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (approved: felt):
    let (approved: felt) = ERC721_getApproved(token_id)
    return (approved)
end

@view
func isApprovedForAll{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(owner: felt, operator: felt) -> (is_approved: felt):
    let (is_approved: felt) = ERC721_isApprovedForAll(owner, operator)
    return (is_approved)
end

#
# Externals
#

@external
func set_aa_name{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(name : felt):
    a_name.write(name)
    return ()
end


@external
func calcNewTokenIdNum{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }():
    alloc_locals
    let (local var_one) = token_id_count.read()
    let (local var_two) = token_id_increment.read()
    let (local idNumTmp) = addNum(var_one, var_two)
    saveTokenIdCount(idNumTmp)
    let token_id: Uint256 = Uint256(idNumTmp,0)
    saveTokenIdValue(token_id)
    return()    
end

@external
func addNum{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(num_one: felt, num_two: felt) -> (idNum: felt):
    return(num_one + num_two)     
end

@external
func saveTokenIdCount{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(num : felt):
    token_id_count.write(num)
    return ()
end

@external
func saveTokenIdValue{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(tokenIDVal : Uint256):
    token_id_value.write(tokenIDVal)
    return ()
end

@external
func saveTokenIdIncrement{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(num : felt):
    token_id_increment.write(num)
    return ()
end

@external
func setAssignedRank{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(rank : felt):
    stored_rank.write(rank)
    return ()
end

@external
func setAssignedLegsNumber{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(legs : felt):
    stored_legs_number.write(legs)
    return ()
end

@external
func setAssignedSexNumber{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(sex : felt):
    stored_sex_number.write(sex)
    return ()
end

@external
func setAssignedWingsNumber{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(wings : felt):
    stored_wings_number.write(wings)
    return ()
end


@external
func approve{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(to: felt, token_id: Uint256):
    ERC721_approve(to, token_id)
    return ()
end

@external
func setApprovalForAll{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(operator: felt, approved: felt):
    ERC721_setApprovalForAll(operator, approved)
    return ()
end

@external
func transferFrom{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(_from: felt, to: felt, token_id: Uint256):
    ERC721_transferFrom(_from, to, token_id)
    return ()
end

@external
func safeTransferFrom{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(
        _from: felt,
        to: felt,
        token_id: Uint256,
        data_len: felt,
        data: felt*
    ):
    ERC721_safeTransferFrom(_from, to, token_id, data_len, data)
    return ()
end

@external
func createNewAnimal{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(token_id: Uint256, sex: felt, legs: felt, wings: felt) ->  (new_animal: MyAnimal):
    alloc_locals
    my_animal.write(token_id, MyAnimal(sex_number=sex, wings_number=wings, legs_number=legs))
    let (local new_animal) = my_animal.read(token_id)
    return (new_animal)
end


@external
func mintToEvaluator{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(to: felt):
    alloc_locals
    #Ownable_only_owner()
    calcNewTokenIdNum()
    let(local token_id) = token_id_value.read()
    ERC721_mint(to, token_id)
    return ()
end

@external
func declare_animal{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(sex: felt, legs: felt, wings: felt) -> (token_id: Uint256):
    alloc_locals
    calcNewTokenIdNum()
    let(local token_id) = token_id_value.read()
    let to = 3160224547644632651535279661899767678482086458911879210087695553296143624415
    my_animal.write(token_id, MyAnimal(sex_number=sex, wings_number=wings, legs_number=legs))
    ERC721_mint(to, token_id)
    return(token_id)    
end




# @external
# func burn{
#         pedersen_ptr: HashBuiltin*,
#         syscall_ptr: felt*,
#         range_check_ptr
#     }(token_id: Uint256):
#     Ownable_only_owner()
#     ERC721_burn(token_id)
#     return ()
# end
