interface psw_if(input bit clk);
    logic [7:0] acc;
    logic [7:0] operand;
    logic add_op;
    logic [7:0] psw;
    
   

   

    clocking drv_cb @(negedge clk);
        default input #1 output #1;
        output acc;
        output operand;
        output add_op;
    endclocking
    clocking mon_cb @(posedge clk);
        default input #1 output #1;
        input acc;
        input operand;
        input add_op;
        input psw;
    endclocking

    modport DRV(clocking drv_cb);
    modport MON(clocking mon_cb);

    // 3. CORRECT: The SVA property checks the condition, it doesn't calculate
    
endinterface