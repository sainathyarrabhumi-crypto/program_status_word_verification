class env extends uvm_env;
`uvm_component_utils(env)
agt agent;
config_psw cfg;
scoreboard sb;
function new(string name="env",uvm_component parent=null);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(config_psw)::get(this,"","cfg",cfg))
`uvm_fatal("CONFIG","cannot get here");
agent=agt::type_id::create("agent",this);
sb=scoreboard::type_id::create("sb",this);
endfunction
function void connect_phase(uvm_phase phase);
agent.mon.mon_ap.connect(sb.sb_ap);
endfunction
endclass