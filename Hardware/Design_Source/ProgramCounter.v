module ProgramCounter(
    input CLK,
    input Reset,
    input PCSrc,
    input [31:0] Result,
    
    output reg [31:0] PC,
    output [31:0] PC_Plus_4
); 

//fill your Verilog code here
reg [31:0] next_PC;
reg [31:0] current_PC;

assign PC_Plus_4 = current_PC + 32'd4;
always@(*)begin
   if(PCSrc==0)begin
      next_PC = PC_Plus_4;
   end
   else begin
      next_PC = Result;
   end
end

always @(posedge CLK ) begin
    if(!Reset)begin
       current_PC <= 32'b0;
    end
    else begin
       current_PC <= next_PC;
    end   
end

endmodule