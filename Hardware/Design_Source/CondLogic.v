module CondLogic(
    input CLK,
    input NoWire,
    input PCS,
    input RegW,
    input MemW,
    input [1:0] FlagW,
    input [3:0] Cond,
    input [3:0] ALUFlags,
    
    output PCSrc,
    output RegWrite,
    output MemWrite
    ); 
    
    reg CondEx ;
    reg N = 0, Z = 0, C = 0, V = 0 ;
    
assign PCSrc = PCS & CondEx;
assign RegWrite = RegW & CondEx & (~NoWire);
assign MemWrite = MemW & CondEx;
always @(posedge CLK ) begin
    if(FlagW[1]==1&&CondEx==1)begin
        N <= ALUFlags[3];
        Z <= ALUFlags[2];
    end
    // else begin
    //     N <= N;
    //     Z <= Z;
    // end
    if(FlagW[0]==1&&CondEx==1)begin
        C <= ALUFlags[1];
        V <= ALUFlags[0];
    end
end   

always@(*)begin
    case(Cond)
        4'd0: CondEx = Z;
        4'd1: CondEx = ~Z;
        4'd2: CondEx = C;
        4'd3: CondEx = ~C;
        4'd4: CondEx = N;
        4'd5: CondEx = ~N;
        4'd6: CondEx = V;
        4'd7: CondEx = ~V;
        4'd8: CondEx = (~Z)&C;
        4'd9: CondEx = Z | (~C);
        4'd10: CondEx = ~(N ^ V);
        4'd11: CondEx = N ^ V;
        4'd12: CondEx = (~Z) & (~(N ^ V));
        4'd13: CondEx = Z | (N ^ V);
        4'd14: CondEx = 1;
        default: CondEx = 0;
    endcase
end 
endmodule