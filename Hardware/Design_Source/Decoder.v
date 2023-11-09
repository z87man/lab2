module Decoder(
    input [31:0] Instr,
    output PCS,
    output RegW, 
    output MemW, 
    output MemtoReg,
    output ALUSrc,
    output [1:0] ImmSrc,
    output [1:0] RegSrregc,
    output reg [1:0] ALUControl,
    output reg [1:0] FlagW,
    output reg NoWire
    ); 
    
    wire ALUOp ; 
    wire Branch ;
    wire [3:0] Rd;
    wire [1:0] op;
    wire [5:0] funct;
assign funct = Instr[25:20];
assign Rd = Instr[15:12];
assign op = Instr[27:26];

assign Branch = (op==2'b10) & (funct[5]==0);
assign ALUOp = (~Instr[27]) & (~Instr[26]);

assign PCS = ((Instr[15:12]==15)&RegW) | Branch;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
assign MemtoReg = ((~Instr[27]) & (Instr[26])) & Instr[20];
assign MemW = ((~Instr[27]) & (Instr[26])) & (~Instr[20]);
assign ALUSrc = (((~Instr[27]) & (~Instr[26])) & (Instr[25])) | (((~Instr[27]) & (Instr[26])) & (~Instr[20])) | ((Instr[27]) & (~Instr[26]));
assign ImmSrc[1] = (Instr[27]) & (~Instr[26]);
assign ImmSrc[0] = (~Instr[27]) & (Instr[26]);
assign RegSrregc[1] = ((~Instr[27]) & (Instr[26])) & (~Instr[20]);
assign RegSrregc[0] = ((Instr[27]) & (~Instr[26])) & (~Instr[20]);
//assign ALUControl[1] = (ALUOp & (~Instr[24]) & (~Instr[23]) & (~Instr[22]) & (~Instr[21])) & (ALUOp & (Instr[24]) & (Instr[23]) & (~Instr[22]) & (~Instr[21]));
always @(*) begin
    if(ALUOp)begin
        if(Instr[24:21]==4'b0000)begin
            ALUControl = 2'b10;
        end
        else if(Instr[24:21]==4'b1100)begin
            ALUControl = 2'b11;
        end
        else if(Instr[24:21]==4'b0010)begin
            ALUControl = 2'b01;
        end
        else if(funct[4:1]==4'b1010)begin
            ALUControl = 2'b01;
        end
        // else if(funct[4:1]==4'b1011)begin
        //     ALUControl = 2'b00;
        // end
        else begin 
            ALUControl = 2'b00;
        end
    end
    else if(funct[3]==1)begin
        ALUControl = 2'b00;
    end
    else begin
        ALUControl = 2'b01;
    end

end
always@(*)begin
    if(ALUOp==1&&Instr[20]==1)begin
        if(Instr[24:21]==4'b0100)begin
            FlagW = 2'b11;
        end
        else if(Instr[24:21]==4'b0010)begin
            FlagW = 2'b11;
        end
        else if(Instr[24:21]==4'b0000)begin
            FlagW = 2'b10;
        end
        else if(Instr[24:21]==4'b1100)begin
            FlagW = 2'b10;
        end
        else if(funct[4:1]==4'b1010)begin
            FlagW = 2'b11;
        end
        else if(funct[4:1]==4'b1011)begin
            FlagW = 2'b11;
        end
        else begin
            FlagW = 2'b00;
        end
    end
    else begin
        FlagW = 2'b00;       
    end
end

always@(*)begin
    if(ALUOp)begin
        if(funct[4:1]==4'b1010)begin
            NoWire = 1;
        end
        else if(funct[4:1]==4'b1011)begin
            NoWire = 1;
        end
        else begin
            NoWire = 0;
        end
    end
    else begin
        NoWire = 0;
    end
end

endmodule