module top;
import uvm_pkg::*;
  import psw_package::*;
bit clk=0;
always #10 clk=~clk;
psw_if in0(.clk(clk));
psw_v dut(.clk(clk),.acc(in0.acc),.add_op(in0.add_op),.operand(in0.operand),.psw(in0.psw));
 wire [8:0] result = {1'b0, in0.acc} + {1'b0, in0.operand};
    wire [4:0] lower_sum = {1'b0, in0.acc[3:0]} + {1'b0, in0.operand[3:0]};

    // 2. Derive the expected flag values continuously
    wire expected_psw_7 = result[8]; // Carry flag
    wire expected_psw_6 = lower_sum[4]; // AC flag
    wire expected_psw_2 = (in0.acc[7] == in0.operand[7]) && (in0.acc[7] != result[7]);
    wire expected_psw_0 = ~(^result[7:0]); // Parity

property p_carry;
  @(posedge clk)
    in0.add_op |=> (in0.psw[7] == $past(result[8]));
endproperty
assert property (p_carry)
  else $error("PSW[7] Carry flag mismatch! Expected=%0b Actual=%0b at time %0t",
              $past(result[8]), in0.psw[7], $time);


property p_ac;
  @(posedge clk)
    in0.add_op |=> (in0.psw[6] == $past(lower_sum[4]));
endproperty
assert property (p_ac)
  else $error("PSW[6] AC flag mismatch! Expected=%0b Actual=%0b at time %0t",
              $past(lower_sum[4]), in0.psw[6], $time);


property p_overflow;
  @(posedge clk)
    in0.add_op |=> (in0.psw[2] == $past((in0.acc[7] == in0.operand[7]) && 
                                        (in0.acc[7] != result[7])));
endproperty
assert property (p_overflow)
  else $error("PSW[2] Overflow flag mismatch! Expected=%0b Actual=%0b at time %0t",
              $past((in0.acc[7] == in0.operand[7]) && (in0.acc[7] != result[7])),
              in0.psw[2], $time);


property p_parity;
  @(posedge clk)
    in0.add_op |=> (in0.psw[0] == $past(~(^result[7:0])));
endproperty
assert property (p_parity)
  else $error("PSW[0] Parity flag mismatch! Expected=%0b Actual=%0b at time %0t",
              $past(~(^result[7:0])), in0.psw[0], $time);

property p2;
  @(posedge clk)
    !in0.add_op |=> (in0.psw == 0);
endproperty
assert property (p2)
  else $error("PSW nonzero when add_op=0! Value=%b at time %0t", in0.psw, $time); 
    
initial
begin
uvm_config_db #(virtual psw_if)::set(null,"*","vif",in0);
run_test();
end
endmodule
