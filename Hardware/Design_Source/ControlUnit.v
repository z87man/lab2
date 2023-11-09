module ControlUnit(
    input [31:0] Instr,
    input [3:0] ALUFlags,
    input CLK,

    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite,
    output [1:0] RegSrc,
    output [1:0] ALUControl,	
    output PCSrc
    ); 
    
    wire [3:0] Cond;
    wire PSC, RegW, MemW;
    wire [1:0] FlagW;
    wire NoWire;

    assign Cond=Instr[31:28];


    CondLogic CondLogic1(
     CLK,
     NoWire,
     PCS,
     RegW,
     MemW,
     FlagW,
     Cond,
     ALUFlags,

     PCSrc,
     RegWrite,
     MemWrite
    );

    Decoder Decoder1(
     Instr,
     PCS,
     RegW,
     MemW,
     MemtoReg,
     ALUSrc,
     ImmSrc,
     RegSrc,
     ALUControl,
     FlagW,
     NoWire
    );
endmodule