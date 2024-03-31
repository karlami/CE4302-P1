import sys
import os

instructions_file_path = sys.argv[1]
compiled_file_path = sys.argv[2]

if (os.path.exists(compiled_file_path)):
    os.remove(compiled_file_path)

instructions_file = open(instructions_file_path, 'r')
compiled_file = open(compiled_file_path, 'a')

empty_nibble = '0000'

op_codes = {
    'Integer Arithmetic': {
        'G3_ADD': '00000',
        'G3_SUB': '00001',
        'G3_MUL': '00010'
    },
    'Integer Control': {
        'G3_LDR': '00100',
        'G3_STR': '00101'
    },
    'Fixed Arithmetic': {
        'G3_FADD': '01000',
        'G3_FSUB': '01001',
        'G3_FMUL': '01010'
    },
    'Fixed Control': {
        'G3_FLDR': '01100',
        'G3_FSTR': '01101'
    },
    'Vectorial Arithmetic': {
        'G3_VADD': '10000',
        'G3_VSUB': '10001',
        'G3_VMUL': '10010'
    },
    'Vectorial Control': {
        'G3_VLDR': '10100',
        'G3_VSTR': '10101'
    },
    'General': {
        'G3_MOVI': '11000',
        'G3_MOVR': '11001',
        'G3_CMP': '11100',
        'G3_B': '11101',
        'G3_BLT': '11110'
    },
    'General Branch': {
        'G3_B': '11101',
        'G3_BLT': '11110'
    }
}

registers = {
    'r0': '0000',
    'r1': '0001',
    'r2': '0010',
    'r3': '0011',
    'r4': '0100',
    'r5': '0101',
    'r6': '0110',
    'r7': '0111',
    'r8': '1000',
    'r9': '1001',
    'r10': '1010',
    'r11': '1011',
}


def to_binary_string(number, width):
    if (number < 0):
        return f'{number % (1 << width):0{width}b}'
    else:
        return f'{number:0{width}b}'


def split_nibbles(binary_string):
    result = []
    for i in range(int(len(binary_string)/4)):
        result.append(f'{binary_string[i*4:(i+1)*4]}')
    return result


def get_op_code(op_code_key):
    for inst_type in op_codes:
        if op_code_key in op_codes[inst_type]:
            op_code = op_codes[inst_type][op_code_key]
            return inst_type, op_code

    raise Exception(f'Error: invalid operation "{op_code_key}"')


def get_register_operand(operand):
    try:
        return registers[operand]
    except KeyError:
        raise Exception(f'Error: invalid operand "{operand}"')


def get_immediate_operand(operand, width):
    try:
        int_operand = int(operand.replace('#0x', ''), 16)
        binary_operand = to_binary_string(int_operand, width)

        if (width % 4 != 0):
            raise Exception(
                f'Error: immediate operand width must be a multiple of 4. Got {width}.')
        if (int_operand > 2**width - 1):
            max_hex_value = f'{(2**width - 1):x}'
            raise Exception(
                f'Error: immediate operand "{operand}" is too large. Max value is {max_hex_value}.')

        return split_nibbles(binary_operand)
    except Exception as error:
        raise Exception(str(error))


def arith_instruction(op_code, operands):
    operand_1 = get_register_operand(operands[0])
    operand_2 = get_register_operand(operands[1])
    operand_3 = get_register_operand(operands[2])
    return [op_code, operand_1, operand_2, operand_3]

def control_instruction(op_code, operands, current_pc, labels):
    if op_code in ['G3_LDR', 'G3_STR', 'G3_FLDR', 'G3_FSTR', 'G3_VLDR', 'G3_VSTR']:
        return memory_instruction(op_code, operands)
    elif op_code in ['G3_MOVI', 'G3_MOVR', 'G3_CMP']:
        return mov_instruction(op_code, operands)
    elif op_code in ['G3_B', 'G3_BLT']:
        return branch_instruction(op_code, operands, current_pc, labels)
    else:
        operand_1 = get_register_operand(operands[0])
        operand_2 = get_register_operand(operands[1])
        return [op_code, operand_1, operand_2, empty_nibble]

def mov_instruction(op_code, operands):
    if op_code == 'G3_MOVI':
        operand_1 = get_register_operand(operands[0])
        operand_2_nibbles = get_immediate_operand(operands[1], 8)
        return [op_code, operand_1, operand_2_nibbles[0], operand_2_nibbles[1]]
    else:
        operand_1 = get_register_operand(operands[0])
        operand_2 = get_register_operand(operands[1])
        return [op_code, operand_1, operand_2, empty_nibble]

def branch_instruction(op_code, operands, current_pc, labels):
    if op_code == 'G3_B' or op_code == 'G3_BLT':
        for label in labels:
            if label['label_name'] == operands[0]:
                label_pc = label['pc']
                branch_pc = label_pc - current_pc

                branch_operand = to_binary_string(branch_pc, 12)
                branch_nibbles = split_nibbles(branch_operand)

                return [op_code, branch_nibbles[0], branch_nibbles[1], branch_nibbles[2]]

        raise Exception(
            f'Error: label "{operands[0]}" not found in program.')
    else:
        raise Exception(f'Error: invalid branch instruction "{op_code}"')


def decode_instruction(op_code_key, operands, current_pc, labels):
    try:
        if op_code_key in op_codes['Integer Arithmetic'] or \
           op_code_key in op_codes['Fixed Arithmetic'] or \
           op_code_key in op_codes['Vectorial Arithmetic']:
            return arith_instruction(op_code_key, operands)
        elif op_code_key in op_codes['Integer Control'] or \
             op_code_key in op_codes['Fixed Control'] or \
             op_code_key in op_codes['Vectorial Control'] or \
             op_code_key in op_codes['General']:
            return control_instruction(op_code_key, operands, current_pc, labels)
        elif op_code_key in op_codes['General Branch']:
            return branch_instruction(op_code_key, operands, current_pc, labels)
    except Exception as error:
        raise Exception(str(error))

instruction_memory_size = 400
pc = 0
labels = []
instructions = []
for instruction in instructions_file:
    instruction = instruction.strip().lower()

    if (instruction == '' or instruction[0] == ';'):
        continue
    elif (instruction[-1] == ':'):
        label = {'label_name': instruction[:-1], 'pc': pc}
        labels.append(label)
        continue

    instructions.append(instruction)
    pc += 4

pc = 0
try:
    for instruction in instructions:
        instruction = instruction.split(' ', 1)

        op_code_key = instruction[0]
        operands = instruction[1].replace(' ', '').split(',')

        instruction_nibbles = decode_instruction(
            op_code_key, operands, pc, labels)

        print(f'PC: {pc}')
        print(instruction)
        print(instruction_nibbles)
        print('-------------------------------------')

        for nibble in instruction_nibbles:
            compiled_file.write(f'{nibble}\n')
            pc += 1

    while pc < instruction_memory_size:
        compiled_file.write(f'{empty_nibble}\n')
        pc += 1

except Exception as error:
    print(str(error))
    os.remove(compiled_file_path)
    sys.exit(1)