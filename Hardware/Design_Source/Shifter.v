module Shifter(
    input [1:0] Sh,
    input [4:0] Shamt5,
    input [31:0] ShIn,
    
    output [31:0] ShOut
    );


// reg [31:0] shOutLSL;
// reg [31:0] shOutLSR;
// reg [31:0] shOutASR;
// reg [31:0] shOutROR;

reg [31:0] A;
reg [31:0] B;
reg [31:0] C;
reg [31:0] D;
reg out;

always@(*)begin
  if(Sh==00)begin
    if(Shamt5[4])begin
        A = {ShIn[15:0],16'b0};
    end
    else begin
        A = ShIn;
    end

    if(Shamt5[3])begin
        B = {A[23:0],8'b0};
    end
    else begin
        B = A;
    end

    if(Shamt5[2])begin
        C = {B[27:0],4'b0};
    end
    else begin
        C = B;
    end

    if(Shamt5[1])begin
        D = {C[29:0],2'b0};
    end
    else begin
        D = C;
    end

    if(Shamt5[0])begin
        out = {D[30:0],1'b0};
    end
    else begin
        out = D;
    end
  end
  else if(Sh==01)begin
    if(Shamt5[4])begin
        A = {16'b0,ShIn[31:16]};
    end
    else begin
        A = ShIn;
    end

    if(Shamt5[3])begin
        B = {8'b0,A[31:9]};
    end
    else begin
        B = A;
    end

    if(Shamt5[2])begin
        C = {4'b0,B[31:5]};
    end
    else begin
        C = B;
    end

    if(Shamt5[1])begin
        D = {2'b0,C[31:3]};
    end
    else begin
        D = C;
    end

    if(Shamt5[0])begin
        out = {1'b0,D[31:30]};
    end
    else begin
        out = D;
    end
  end
  else if(Sh==10)begin
    if(Shamt5[4])begin
        A = {ShIn[31],15'b0,ShIn[31:16]};
    end
    else begin
        A = ShIn;
    end

    if(Shamt5[3])begin
        B = {ShIn[31],7'b0,A[31:8]};
    end
    else begin
        B = A;
    end

    if(Shamt5[2])begin
        C = {ShIn[31],3'b0,B[31:4]};
    end
    else begin
        C = B;
    end

    if(Shamt5[1])begin
        D = {ShIn[31],1'b0,C[31:2]};
    end
    else begin
        D = C;
    end

    if(Shamt5[0])begin
        out = {ShIn[31],D[31:1]};
    end
    else begin
        out = D;
    end
  end
  else begin
    if(Shamt5[4])begin
        A = {ShIn[15:0],ShIn[31:16]};
    end
    else begin
        A = ShIn;
    end

    if(Shamt5[3])begin
        B = {ShIn[7:0],A[31:8]};
    end
    else begin
        B = A;
    end

    if(Shamt5[2])begin
        C = {ShIn[3:0],B[31:4]};
    end
    else begin
        C = B;
    end

    if(Shamt5[1])begin
        D = {ShIn[1:0],C[31:2]};
    end
    else begin
        D = C;
    end

    if(Shamt5[0])begin
        out = {ShIn[0],D[31:1]};
    end
    else begin
        out = D;
    end
  end
end

assign ShOut = out;



endmodule 
