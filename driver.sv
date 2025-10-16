class driver extends uvm_driver #(seq_txn);
`uvm_component_utils(driver)
virtual psw_if.DRV vif;
config_psw cfg;
function new(string name="driver",uvm_component parent=null);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(config_psw)::get(this,"","cfg",cfg))
`uvm_fatal("CONFIG","cant get it,have u set()")
endfunction
function void connect_phase(uvm_phase phase);
vif=cfg.vif;
endfunction
task run_phase(uvm_phase phase);
seq_txn txn;
forever
begin
seq_item_port.get_next_item(txn);
send_to_dut(txn);
seq_item_port.item_done();
end
endtask
task send_to_dut(seq_txn txn);
`uvm_info("DRIVER",$sformatf("printing from driver \n %s",txn.sprint()),UVM_LOW)
@(vif.drv_cb);
vif.drv_cb.add_op<=txn.add_op;
vif.drv_cb.acc<=txn.acc;
vif.drv_cb.operand<=txn.operand;
@(vif.drv_cb);
endtask
endclass