class sequence_base extends uvm_sequence #(seq_txn);
`uvm_object_utils(sequence_base);
function new(string name="sequence_base");
super.new(name);
endfunction
task body();
repeat(10) begin
seq_txn txn;
txn=seq_txn::type_id::create("txn");
start_item(txn);
assert(txn.randomize());
finish_item(txn);
end
endtask
endclass
class sequence_poverflow extends sequence_base;
`uvm_object_utils(sequence_poverflow);
function new(string name="sequence_poverflow");
super.new(name);
endfunction
task body();
repeat(10) begin
seq_txn txn;
txn=seq_txn::type_id::create("txn");
start_item(txn);
assert(txn.randomize() with { txn.acc[7] == 1'b0;
            txn.operand[7] == 1'b0;
txn.add_op==1;
 txn.acc + txn.operand >= 8'd128;}); 
finish_item(txn);
end
endtask
endclass
class sequence_noverflow extends sequence_base;
`uvm_object_utils(sequence_noverflow);
function new(string name="sequence_noverflow");
super.new(name);
endfunction
task body();
repeat(10) begin
seq_txn txn;
txn=seq_txn::type_id::create("txn");
start_item(txn);
assert(txn.randomize() with { txn.acc[7] == 1'b1;
            txn.operand[7] == 1'b1;
txn.add_op==1;
 txn.acc + txn.operand <= 8'd128;}); 
finish_item(txn);
end
endtask
endclass
class sequence_acc extends sequence_base;
`uvm_object_utils(sequence_acc);
function new(string name="sequence_acc");
super.new(name);
endfunction
task body();
repeat(10) begin
seq_txn txn;
txn=seq_txn::type_id::create("txn");
start_item(txn);
assert(txn.randomize() with {txn.add_op==1;(txn.acc[3:0] + txn.operand[3:0]) >= 5'd16;}); 
finish_item(txn);
end
endtask
endclass
class sequence_last extends sequence_base;
`uvm_object_utils(sequence_last)
function new(string name="sequence_last");
super.new(name);
endfunction
task body();
repeat(10) begin
seq_txn txn;
txn=seq_txn::type_id::create("txn");
start_item(txn);
assert(txn.randomize() with {txn.add_op==0;}); 
finish_item(txn);
end
endtask
endclass
class sequence_carry extends sequence_base;
`uvm_object_utils(sequence_carry)
function new(string name="sequence_carry");
super.new(name);
endfunction
task body();
repeat(10) begin
seq_txn txn;
txn=seq_txn::type_id::create("txn");
start_item(txn);
assert(txn.randomize() with {txn.add_op==1;(txn.acc+txn.operand)>8'd254;}); 
finish_item(txn);
end
endtask
endclass