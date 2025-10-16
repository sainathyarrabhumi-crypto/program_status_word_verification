class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    uvm_analysis_imp #(seq_txn, scoreboard) sb_ap;

    seq_txn coverage_txn; 

    int success_count = 0;
    int failure_count = 0;

    covergroup cg;
        option.at_least=1;
        
        s1: coverpoint coverage_txn.add_op;
        
       
        s3: coverpoint (coverage_txn.acc[3:0] + coverage_txn.operand[3:0]) { 
            bins no_ac = {0, 8, 15};
            bins has_ac = {0,2,15};
        } 

        s4: coverpoint coverage_txn.psw[6];
        s5: coverpoint coverage_txn.psw[2];
        s6: coverpoint coverage_txn.psw[0];
        s7: coverpoint coverage_txn.psw[7];
        
        
    endgroup : cg

    function new(string name="scoreboard", uvm_component parent=null); 
        super.new(name,parent);
        sb_ap = new("sb_ap", this);
        cg = new();
    endfunction

    virtual function void write(seq_txn txn);
        $cast(coverage_txn, txn.clone()); 
        
        cg.sample();
        
        check_data(txn);
    endfunction

    function void check_data(seq_txn txn);
        bit [8:0] result;
        bit [4:0] limited_res;
        bit [7:0] expected_psw = 8'h00; 

        result = {1'b0, txn.acc} + {1'b0, txn.operand}; 
        
        limited_res = {1'b0, txn.acc[3:0]} + {1'b0, txn.operand[3:0]}; 

        if (txn.add_op) begin
            expected_psw[7] = result[8]; 
            
            expected_psw[6] = limited_res[4]; 
            
            expected_psw[2] = ((txn.acc[7] == txn.operand[7]) && (txn.acc[7] != result[7])); 
            
            expected_psw[0] = ~(^result[7:0]);
        end

        if (txn.add_op && txn.psw != expected_psw) begin
            failure_count++;
            `uvm_error("SCOREBOARD",  $sformatf("MISMATCH DETECTED for ACC=%0h, OP=%0h!\n,\tEXPECTED PSW: %0h\n,\tACTUAL PSW:   %0h", txn.acc, txn.operand, expected_psw, txn.psw))
        end else begin
             success_count++;
             `uvm_info("SCOREBOARD","Transaction passed.",UVM_LOW)
        end
    endfunction
    
    function void report_phase(uvm_phase phase);
        `uvm_info("SCOREBOARD_SUMMARY", 
            $sformatf("--- SCOREBOARD SUMMARY ---\n,SUCCESSFUL Transactions: %0d\n,FAILED Transactions: %0d\n,TEST %s!", success_count, failure_count, 
                      (failure_count == 0) ? "PASSED" : "FAILED"), UVM_NONE)
    endfunction
endclass
