

(LOOP)

  @SCREEN
  D=A
  @pixels
  M=D 
          // pixel address, goes from 16384 to 16384 + 8192 == 24576
  @KBD    // keyboard address
  D=M
  @COLOR_SCREEN
  D;JGT

   @pixels
    A=M         // VERY IMPORTANT! indirect address
    M=0         // color M[pixels] with @color
    
    @pixels
    M=M+1
    D=M
        
    @24576
    D=D-A
    @LOOP
    D;JLT
 
  (COLOR_SCREEN)
    @pixels
    A=M         // VERY IMPORTANT! indirect address
    M=-1         // color M[pixels] with @color
    
    @pixels
    M=M+1
    D=M
        
    @24576
    D=D-A
    @COLOR_SCREEN
    D;JLT

@LOOP
0;JMP      
