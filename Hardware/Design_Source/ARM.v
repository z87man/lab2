module ARM(
    input CLK,
    input Reset,
    input [31:0] Instr,
    input [31:0] ReadData,

    output MemWrite,
    output [31:0] PC,
    output [31:0] ALUResult,
    output [31:0] WriteData
); 


wire [31:0] RD2;
wire [31:0] ShOut;
Shifter shfter1(
    Instr[6:5],
    Instr[11:7],
    RD2,
    
    ShOut
    );

wire RegWrite;
reg [3:0] A1;
wire [1:0] RegSrc;
reg [3:0] A2;
always@(*)begin
    if(RegSrc[0])begin
        A1 = 4'd15;
    end
    else begin
        A1 = Instr[19:16];
    end
end
always@(*)begin
    if(RegSrc[1])begin
        A2 = Instr[15:12];
    end
    else begin
        A2 = Instr[3:0];
    end
end
reg [31:0]Result;
wire MemtoReg;
always@(*)begin
    if(MemtoReg)begin
        Result = ReadData;
    end
    else begin
        Result = ALUResult;
    end
end
wire [31:0] R15;
wire [31:0] PC_Plus_4;
assign R15 = PC_Plus_4 + 31'd4;
wire [31:0] RD1;
RegisterFile RegisterFile1(
    CLK,
    RegWrite,
    A1,
    A2,
    Instr[15:12],
    Result,
    R15,

    RD1,
    RD2
    );

wire [3:0] ALUFlags; 
wire ALUSrc;
wire [1:0] ImmSrc; 
wire [1:0] ALUControl; 
wire PCSrc;  
ControlUnit ControlUnit1 (
    Instr,
    ALUFlags,
    CLK,

    MemtoReg,
    MemWrite,
    ALUSrc,
    ImmSrc,
    RegWrite,
    RegSrc,
    ALUControl,	
    PCSrc
  );


  ProgramCounter ProgramCounter1(
    CLK,
    Reset,
    PCSrc,
    Result,

    PC,
    PC_Plus_4
);


reg [31:0]Src_B;
wire [31:0] ExtImm;
always@(*)begin
    if(ALUSrc)begin
        Src_B = ExtImm;
    end
    else begin
        Src_B = ShOut;
    end
end
ALU alu1(
    RD1,
    Src_B,
    ALUControl,

    ALUResult,
    ALUFlags
    );

  Extend Extend1(
    ImmSrc,
    Instr[23:0],
    
    ExtImm
  );





endmodule