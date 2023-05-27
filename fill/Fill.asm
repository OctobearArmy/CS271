// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(LOOP)
  @KBD
  D=M            

  @BLACK_SCREEN
  D;JGT // If D > 0, go to BLACK_SCREEN

  @CLEAR_SCREEN
  0;JMP // els, go to CLEAR_SCREEN

  (BLACK_SCREEN)
    @SCREEN
    D=A
    @pixel
    M=D // Set the pixel address

    (BLACK_LOOP)
      @pixel
      A=M // Load the pixel address
      M=-1           

      @pixel
      M=M+1 // Increment the pixel address
      D=M

      @24576
      D=D-A
      @BLACK_LOOP
      D;JLT 

    @LOOP
    0;JMP

  (CLEAR_SCREEN) //same as BLACK_SCREEN only M=0 (white)
    @SCREEN
    D=A
    @pixel
    M=D // Set the pixel address

    (CLEAR_LOOP) 
      @pixel
      A=M // Load the pixel address
      M=0 

      @pixel
      M=M+1 // Increment the pixel address
      D=M

      @24576
      D=D-A
      @CLEAR_LOOP
      D;JLT

  @LOOP
  0;JMP

