(LOOP)
  @KBD
  D=M            // Load the keyboard value

  @BLACK_SCREEN
  D;JGT          // If keyboard > 0, go to BLACK_SCREEN

  @CLEAR_SCREEN
  0;JMP          // Otherwise, go to CLEAR_SCREEN

  (BLACK_SCREEN)
    @SCREEN
    D=A
    @pixels
    M=D            // Set the pixel address

    (BLACK_LOOP)
      @pixels
      A=M            // Load the pixel address
      M=-1           // Set the color to -1 (black)

      @pixels
      M=M+1          // Increment the pixel address
      D=M

      @24576
      D=D-A
      @BLACK_LOOP
      D;JLT          // Jump if D < 8192 to continue blackening the screen

    @LOOP
    0;JMP

  (CLEAR_SCREEN)
    @SCREEN
    D=A
    @pixels
    M=D            // Set the pixel address

    (CLEAR_LOOP)
      @pixels
      A=M            // Load the pixel address
      M=0            // Set the color to 0 (white)

      @pixels
      M=M+1          // Increment the pixel address
      D=M

      @24576
      D=D-A
      @CLEAR_LOOP
      D;JLT          // Jump if D < 8192 to continue clearing the screen

  @LOOP
  0;JMP
