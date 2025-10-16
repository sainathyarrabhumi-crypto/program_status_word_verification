module psw_v (
    input  [7:0] acc,
    input  [7:0] operand,
    input  add_op,
    input  clk,
    output reg [7:0] psw
);

reg [8:0] result;
reg [4:0] lower_sum;

always @(posedge clk) begin
    if (add_op) begin
        result = {1'b0, acc} + {1'b0, operand};
        psw[7] = result[8]; // Carry flag

        lower_sum = {1'b0, acc[3:0]} + {1'b0, operand[3:0]};
        psw[6] = lower_sum[4]; // AC flag

        psw[2] = ((acc[7] == operand[7]) && (acc[7] != result[7])); 

        psw[0] = ~(^result[7:0]); // Parity
    end
    else
    psw<=0;
end
endmodule