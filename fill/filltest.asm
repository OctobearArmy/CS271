(LOOP)
  @KEYBOARD
  D=M
  @KEY_PRESSED
  D;JNE      // Jump to KEY_PRESSED if keyboard is pressed
  
  // Keyboard not pressed, clear the registers (white)
  @SCREEN
  D=A
  @pixels
  M=D

  (CLEAR_SCREEN)
  M=0
  D=M
  @pixels
  A=M
  M=D
  
  @pixels
  M=M+1
  D=M
  
  @SCREENEND
  D=D-A
  @CLEAR_SCREEN
  D;JLT
  
  @LOOP
  0;JMP

(KEY_PRESSED)
  // Keyboard pressed, fill the registers with -1 (black)
  @SCREEN
  D=A
  @pixels
  M=D
  
  (COLOR_SCREEN)
  M=-1
  D=M
  @pixels
  A=M
  M=D
  
  @pixels
  M=M+1
  D=M
  
  @SCREENEND
  D=D-A
  @COLOR_SCREEN
  D;JLT
  
  @LOOP
  0;JMP
