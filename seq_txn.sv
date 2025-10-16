class seq_txn extends uvm_sequence_item;
rand logic[7:0]acc;
rand logic[7:0]operand;
rand logic add_op;
logic[7:0]psw;
`uvm_object_utils_begin(seq_txn)
`uvm_field_int(acc,UVM_ALL_ON)
`uvm_field_int(operand,UVM_ALL_ON)
`uvm_field_int(add_op,UVM_ALL_ON)
`uvm_field_int(psw,UVM_NOCOMPARE)
`uvm_object_utils_end
function new(string name="seq_txn");
super.new(name);
endfunction
endclass