module ALU(
    input [31:0] Src_A,
    input [31:0] Src_B,
    input [1:0] ALUControl,
    output [31:0] ALUResult,
    output [3:0] ALUFlags
    );
     
reg [32:0]result;
reg [3:0] flag;
assign ALUResult = result[31:0];
assign ALUFlags = flag;
always@(*)begin
    if(ALUControl==2'b00)begin
        result = Src_A + Src_B;
        if(result[31]==1)begin 
            flag[3] = 1;
        end
        else begin
            flag[3] = 0;
        end
        
        if(result==0)begin
            flag[2] = 1;
        end
        else begin
            flag[2] = 0;
        end
        
        if(result[32]==1)begin
            flag[1] = 1;
        end
        else begin
            flag[1] = 1;
        end

        if(Src_A[31]==Src_B[31]&&Src_A[31]!=result[31])begin
            flag[0] = 1;
        end
        else begin
            flag[0] = 0;
        end
    end
    else if(ALUControl==2'b01)begin
        result = Src_A + (~Src_B+1);
        if(result[31]==1)begin 
            flag[3] = 1;
        end
        else begin
            flag[3] = 0;
        end
        
        if(result==0)begin
            flag[2] = 1;
        end
        else begin
            flag[2] = 0;
        end
        
        if(result[32]==1)begin
            flag[1] = 1;
        end
        else begin
            flag[1] = 1;
        end

        if(Src_A[31]!=Src_B[31]&&Src_A[31]!=result[31])begin
            flag[0] = 1;
        end
        else begin
            flag[0] = 0;
        end
    end
    else if(ALUControl==2'b10)begin
        result = Src_A & Src_B;
        if(result[31]==1)begin 
            flag[3] = 1;
        end
        else begin
            flag[3] = 0;
        end
        
        if(result==0)begin
            flag[2] = 1;
        end
        else begin
            flag[2] = 0;
        end

    end
    else begin
        result = Src_A | Src_B;
        if(result[31]==1)begin 
            flag[3] = 1;
        end
        else begin
            flag[3] = 0;
        end
        
        if(result==0)begin
            flag[2] = 1;
        end
        else begin
            flag[2] = 0;
        end
    end
end
// always@(*)begin

// end

endmodule













