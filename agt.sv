class agt extends uvm_agent;
`uvm_component_utils(agt)
driver drv;
monitor mon;
sequencer seqr;
config_psw cfg;
function new(string name="agt",uvm_component parent=null);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(config_psw)::get(this,"","cfg",cfg))
`uvm_fatal("CONFIG","cant get here");
mon=monitor::type_id::create("mon",this);
if(cfg.is_active)
begin
drv=driver::type_id::create("drv",this);
seqr=sequencer::type_id::create("seqr",this);
end
endfunction
function void connect_phase(uvm_phase phase);
if(cfg.is_active)
drv.seq_item_port.connect(seqr.seq_item_export);
endfunction
endclass