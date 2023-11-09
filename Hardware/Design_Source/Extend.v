module Extend(
    input [1:0] ImmSrc,
    input [23:0] InstrImm,
    output reg [31:0] ExtImm
    );  
    

always@(*)begin
    if(ImmSrc==2'b00)begin
       ExtImm[31:8] = 24'b0;
       ExtImm[7:0] = InstrImm[7:0];
    end
    else if(ImmSrc==2'b01)begin
       ExtImm[31:12] = 20'b0;
       ExtImm[12:0] = InstrImm[12:0];
    end
    else if(ImmSrc==2'b10)begin
       ExtImm[31:26] = {InstrImm[23],InstrImm[23],InstrImm[23],InstrImm[23],InstrImm[23],InstrImm[23]};
       ExtImm[25:2] = InstrImm[23:0];
       ExtImm[2:0] = 2'b00;
    end
end
endmodule
