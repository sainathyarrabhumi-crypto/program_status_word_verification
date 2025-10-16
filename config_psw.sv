class config_psw extends uvm_object;
`uvm_object_utils(config_psw);
function new(string name="config_psw");
super.new(name);
endfunction
 virtual psw_if vif;
bit is_active;
endclass