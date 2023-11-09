module RegisterFile(
    input CLK,
    input WE3,
    input [3:0] A1,
    input [3:0] A2,
    input [3:0] A3,
    input [31:0] WD3,
    input [31:0] R15,

    output [31:0] RD1,
    output [31:0] RD2
    );
    
    // declare RegBank
    reg [31:0] RegBank[0:14] ;  
reg [31:0] rd1;
reg [31:0] rd2;
always @(*) begin
    if(A1==4'd15)begin
        rd1 = R15;
    end
    else begin
        rd1 = RegBank[A1];
    end

    if(A2==4'd15)begin
        rd2 = R15;
    end
    else begin
        rd2 = RegBank[A2];
    end
end
always @(posedge CLK ) begin
    if(WE3)begin
        RegBank[A3] <= WD3;
        // RegBank[15] <=R15;
    end  
    
end
assign RD1 = rd1;
assign RD2 = rd2;
endmodule