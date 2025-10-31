
class base_test extends uvm_test;
`uvm_component_utils(base_test)
virtual psw_if vif;
env env_h;
config_psw cfg;
function new(string name="base_test",uvm_component parent=null);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
cfg=config_psw::type_id::create("cfg");
if(!uvm_config_db #(virtual psw_if)::get(this,"","vif",vif))
`uvm_fatal("INTERFACE","cannot get interface")
cfg.vif=vif;
cfg.is_active=UVM_ACTIVE;
uvm_config_db #(config_psw)::set(this,"*","cfg",cfg);
env_h=env::type_id::create("env_h",this);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology;
endfunction
task run_phase(uvm_phase phase);
 begin
sequence_base seq;
seq=sequence_base::type_id::create("seq");
phase.raise_objection(this);
seq.start(env_h.agent.seqr);
phase.drop_objection(this);
end
endtask
endclass
class test1 extends base_test;
`uvm_component_utils(test1)
function new(string name="test1",uvm_component parent=null);
super.new(name,parent);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology;
endfunction
task run_phase(uvm_phase phase);
 begin
sequence_poverflow seq;
seq=sequence_poverflow::type_id::create("seq");
phase.raise_objection(this);
seq.start(env_h.agent.seqr);
phase.drop_objection(this);
end
endtask
endclass
class test2 extends base_test;
`uvm_component_utils(test2)
function new(string name="test2",uvm_component parent=null);
super.new(name,parent);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology;
endfunction
task run_phase(uvm_phase phase);
 begin
sequence_noverflow seq;
seq=sequence_noverflow::type_id::create("seq");
phase.raise_objection(this);
seq.start(env_h.agent.seqr);
phase.drop_objection(this);
end
endtask
endclass
class test3 extends base_test;
`uvm_component_utils(test3)
function new(string name="test3",uvm_component parent=null);
super.new(name,parent);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology;
endfunction
task run_phase(uvm_phase phase);
begin
sequence_acc seq;
seq=sequence_acc::type_id::create("seq");
phase.raise_objection(this);
seq.start(env_h.agent.seqr);
phase.drop_objection(this);
end
endtask
endclass
class test4 extends base_test;
`uvm_component_utils(test4)
function new(string name="test4",uvm_component parent=null);
super.new(name,parent);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology;
endfunction
task run_phase(uvm_phase phase);
 begin
sequence_carry seq;
seq=sequence_carry::type_id::create("seq");
phase.raise_objection(this);
seq.start(env_h.agent.seqr);
phase.drop_objection(this);
end
endtask
endclass
class test5 extends base_test;
`uvm_component_utils(test5)
function new(string name="test5",uvm_component parent=null);
super.new(name,parent);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology;
endfunction
task run_phase(uvm_phase phase);
begin
sequence_last seq;
seq=sequence_last::type_id::create("seq");
phase.raise_objection(this);
seq.start(env_h.agent.seqr);
phase.drop_objection(this);
end
endtask
endclass
