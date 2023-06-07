import sys

comp_dict = {'0'  :'0101010', \
             '1'  :'0111111', \
            '-1'  :'0111010', \
             'D'  :'0001100', \
             'A'  :'0110000', \
            '!D'  :'0001101', \
            '!A'  :'0110001', \
            '-D'  :'0001111', \
            '-A'  :'0110011', \
             'D+1':'0011111', \
             'A+1':'0110111', \
             'D-1':'0001110', \
             'A-1':'0110010', \
             'D+A':'0000010', \
             'D-A':'0010011', \
             'A-D':'0000111', \
             'D&A':'0000000', \
             'D|A':'0010101', \
             'M'  :'1110000', \
            '!M'  :'1110001', \
            '-M'  :'1110011', \
             'M+1':'1110111', \
             'M-1':'1110010', \
             'D+M':'1000010', \
             'D-M':'1010011', \
             'M-D':'1000111', \
             'D&M':'1000000', \
             'D|M':'1010101'}

dest_dict = {'null':'000', \
             'M'   :'001', \
             'D'   :'010', \
             'DM'  :'011', \
             'MD'  :'011', \
             'A'   :'100', \
             'AM'  :'101', \
             'MA'  :'101', \
             'AD'  :'110', \
             'DA'  :'110', \
             'ADM' :'111', \
             'AMD' :'111', \
             'DAM' :'111', \
             'DMA' :'111', \
             'MAD' :'111', \
             'MDA' :'111'}

jump_dict = {'null':'000', \
             'JGT' :'001', \
             'JEQ' :'010', \
             'JGE' :'011', \
             'JLT' :'100', \
             'JNE' :'101', \
             'JLE' :'110', \
             'JMP' :'111'}

symbolMap = {'SP'    : 0, \
             'LCL'   : 1, \
             'ARG'   : 2, \
             'THIS'  : 3, \
             'THAT'  : 4, \
             'R0'    : 0, \
             'R1'    : 1, \
             'R2'    : 2, \
             'R3'    : 3, \
             'R4'    : 4, \
             'R5'    : 5, \
             'R6'    : 6, \
             'R7'    : 7, \
             'R8'    : 8, \
             'R9'    : 9, \
             'R10'   : 10, \
             'R11'   : 11, \
             'R12'   : 12, \
             'R13'   : 13, \
             'R14'   : 14, \
             'R15'   : 15, \
             'SCREEN': 16384, \
             'KBD'   : 24576}

next_data = 16
next_code = 0

def parse(line: str) -> str:
  # Remove comments and strip white space at front and back.
  line = line.split("//")[0].strip()
  # Remove all internal white space (spaces and tabs).
  line = line.replace(' ', '').replace('\t', '')
  return line

def a_instr(line: str) -> str:
  global symbolMap
  global next_data

  line = line[1:]
  if line[0].isnumeric():
    val = int(line)
    # print('Val:', val)
    # print('Bin:', bin(val))
    if val <= 32767: return '0' + bin(val)[2:].zfill(15)
    else:
      print(f'ERROR: Value ({val}) exceeds limit (32767).') #val > 0111 1111 1111 1111
      return ''
  if line in symbolMap: val = symbolMap[line]
  else:
    val = symbolMap[line] = next_data
    next_data += 1
  return '0' + bin(val)[2:].zfill(15)

# def l_instr(line: str):
#   global symbolMap
#   global next_code
  
#   line = line[1:-1]
#   symbolMap[line] = next_code

def c_instr(line: str) -> str:
  global comp_dict
  global dest_dict
  global jump_dict
  
  jump  = 'null'
  parts = line.split(';', 1)
  if   len(parts) > 1: jump = parts[1]
  comp  = parts[0]
  dest  = 'null'
  parts = comp.split('=', 1)
  if   len(parts) == 1: comp = parts[0];  dest = 'null'
  elif len(parts) == 2: dest = parts[0];  comp = parts[1]
  comp = comp_dict[comp]
  dest = dest_dict[dest]
  jump = jump_dict[jump]
  return '111' + comp + dest + jump

def translate(line:str) -> str:
  if line.startswith('@'): return a_instr(line)
  return c_instr(line)

def write_code(write_filename, code):
  with open(write_filename, 'w') as file:
    for line in code:
      file.write(line + '\n')

def main():
  global next_code

  # print(sys.argv[0])
  # print(sys.argv[1])
  filename = sys.argv[1]
  file_lines = []
  with open(filename, 'r') as file:
    file_lines = file.readlines()  # Read in lines of code.
  # print('File contents:')
  # for line in file_lines:
  #   print(line, end='')
  
  # Parse lines (strip out comments and white space).
  parsed = []
  for line in file_lines:
    line = parse(line)
    if len(line) > 0: parsed.append(line)
  
  # Translate labels to code positions.
  lines = []
  for line in parsed:
    if line.startswith('('):
      symbolMap[line[1:-1]] = next_code
    else:
      lines.append(line)
      next_code += 1

  # Translate lines to machine code.
  code = []
  for line in lines:
    code.append(translate(line))
    write_code('prog1.hack', code)
  # for c in code:
  #   print(c)
    

if __name__ == "__main__":
  main()