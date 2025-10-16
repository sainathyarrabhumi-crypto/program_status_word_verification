class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
virtual psw_if.MON vif;
config_psw cfg;
uvm_analysis_port #(seq_txn)mon_ap;
function new(string name="monitor",uvm_component parent=null);
super.new(name,parent);
mon_ap=new("mon_ap",this);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(config_psw)::get(this,"","cfg",cfg))
`uvm_fatal("CONFIG","cant get here");
endfunction
function void connect_phase(uvm_phase phase);
vif=cfg.vif;
endfunction
task run_phase(uvm_phase phase);
forever
collect_data();
endtask
task collect_data();
seq_txn txn;
txn=seq_txn::type_id::create("txn");
@(vif.mon_cb);
txn.add_op=vif.mon_cb.add_op;
txn.acc=vif.mon_cb.acc;
txn.operand=vif.mon_cb.operand;
@(vif.mon_cb);
txn.psw=vif.mon_cb.psw;
`uvm_info("MONITOR",$sformatf("from monitor \n %s",txn.sprint()),UVM_LOW)
mon_ap.write(txn);
endtask
endclass