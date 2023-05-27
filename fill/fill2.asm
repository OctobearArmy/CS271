

(LOOP)

  @SCREEN
  D=A
  @pixels
  M=D         // pixel address, goes from 16384 to 16384 + 8192 == 24576

 
   (COLOR_SCREEN)
   M=-1
    D=M
    @pixels
    A=M         // VERY IMPORTANT! indirect address
    M=D         // color M[pixels] with @color
    
    @pixels
    M=M+1
    D=M
        
    @24576
    D=D-A
    @COLOR_SCREEN
    D;JLT

@LOOP
0;JMP      
