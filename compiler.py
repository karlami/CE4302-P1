import sys
import os

instructions_file = open("arith.txt", 'r')
compiled_file = open("compiled.txt", 'a')

# 13 bits to complete 32 bits
empty_bits_13 = '0000000000000'
# 6 bits to complete 32 bits
empty_bits_6 = '000000'

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
        'G3_CMP': '11100'
    },
    'General Branch': {
        'G3_B': '11101',
        'G3_BLT': '11110'
    },
    'Mov': {
        'G3_MOVI': '11000',
        'G3_MOVR': '11001',
    }
}

scalar_registers = {
    'r0': '0000000',
    'r1': '0000001',
    'r2': '0000010',
    'r3': '0000011',
    'r4': '0000100',
    'r5': '0000101',
    'r6': '0000110',
    'r7': '0000111',
    'r8': '0001000',
    'r9': '0001001',
    'r10': '0001010',
    'r11': '0001011',
    'r12': '0001100',
    'r13': '0001101',
    'r14': '0001110',
    'r15': '0001111',
    'r16': '0010000',
    'r17': '0010001',
    'r18': '0010010',
    'r19': '0010011',
    'r20': '0010100',
    'r21': '0010101',
    'r22': '0010110',
    'r23': '0010111',
    'r24': '0011000',
    'r25': '0011001',
    'r26': '0011010',
    'r27': '0011011',
    'r28': '0011100',
    'r29': '0011101',
    'r30': '0011110',
    'r31': '0011111'
}

vectorial_registers = {
    'vr0': '0000000',
    'vr1': '0000001',
    'vr2': '0000010',
    'vr3': '0000011',
    'vr4': '0000100',
    'vr5': '0000101',
    'vr6': '0000110',
    'vr7': '0000111',
    'vr8': '0001000',
    'vr9': '0001001',
    'vr10': '0001010',
    'vr11': '0001011',
    'vr12': '0001100',
    'vr13': '0001101',
    'vr14': '0001110',
    'vr15': '0001111',
    'vr16': '0010000',
    'vr17': '0010001',
    'vr18': '0010010',
    'vr19': '0010011',
    'vr20': '0010100',
    'vr21': '0010101',
    'vr22': '0010110',
    'vr23': '0010111',
    'vr24': '0011000',
    'vr25': '0011001',
    'vr26': '0011010',
    'vr27': '0011011',
    'vr28': '0011100',
    'vr29': '0011101',
    'vr30': '0011110',
    'vr31': '0011111',
    'vr32': '0100000',
    'vr33': '0100001',
    'vr34': '0100010',
    'vr35': '0100011',
    'vr36': '0100100',
    'vr37': '0100101',
    'vr38': '0100110',
    'vr39': '0100111',
    'vr40': '0101000',
    'vr41': '0101001',
    'vr42': '0101010',
    'vr43': '0101011',
    'vr44': '0101100',
    'vr45': '0101101',
    'vr46': '0101110',
    'vr47': '0101111',
    'vr48': '0110000',
    'vr49': '0110001',
    'vr50': '0110010',
    'vr51': '0110011',
    'vr52': '0110100',
    'vr53': '0110101',
    'vr54': '0110110',
    'vr55': '0110111',
    'vr56': '0111000',
    'vr57': '0111001',
    'vr58': '0111010',
    'vr59': '0111011',
    'vr60': '0111100',
    'vr61': '0111101',
    'vr62': '0111110',
    'vr63': '0111111',
    'vr64': '1000000',
    'vr65': '1000001',
    'vr66': '1000010',
    'vr67': '1000011',
    'vr68': '1000100',
    'vr69': '1000101',
    'vr70': '1000110',
    'vr71': '1000111',
    'vr72': '1001000',
    'vr73': '1001001',
    'vr74': '1001010',
    'vr75': '1001011',
    'vr76': '1001100',
    'vr77': '1001101',
    'vr78': '1001110',
    'vr79': '1001111'
}

def to_binary_string(number, width):
    if (number < 0):
        return f'{number % (1 << width):0{width}b}'
    else:
        return f'{number:0{width}b}'

def get_op_code(op_code_key):
    for inst_type in op_codes:
        if op_code_key in op_codes[inst_type]:
            op_code = op_codes[inst_type][op_code_key]
            return inst_type, op_code

    raise Exception(f'Error: invalid operation "{op_code_key}"')

def get_register_operand(operand):
    try:
        return scalar_registers[operand]
    except KeyError:
        raise Exception(f'Error: invalid operand "{operand}"')

def get_vect_register_operand(operand):
    try:
        return vectorial_registers[operand]
    except KeyError:
        raise Exception(f'Error: invalid operand "{operand}"')

def get_immediate_operand(operand, width):
    try:
        int_operand = int(operand.replace('#0x', ''), 16)
        binary_operand = to_binary_string(int_operand, width)

        if (int_operand > 2**width - 1):
            max_hex_value = f'{(2**width - 1):x}'
            raise Exception(
                f'Error: immediate operand "{operand}" is too large. Max value is {max_hex_value}.')

        return binary_operand
    except Exception as error:
        raise Exception(str(error))

def arith_instruction(op_code, operands):
    operand_1 = get_register_operand(operands[0])
    operand_2 = get_register_operand(operands[1])
    operand_3 = get_register_operand(operands[2])
    return [op_code, operand_1, operand_2, operand_3, empty_bits_6]

def arith_vect_instruction(op_code, operands):
    operand_1 = get_vect_register_operand(operands[0])
    operand_2 = get_vect_register_operand(operands[1])
    operand_3 = get_vect_register_operand(operands[2])
    return [op_code, operand_1, operand_2, operand_3, empty_bits_6]

def control_instruction(op_code, operands):
    operand_1 = get_register_operand(operands[0])
    operand_2 = get_register_operand(operands[1])
    return [op_code, operand_1, operand_2, empty_bits_13]
    
def control_vect_instruction(op_code, operands):
    operand_1 = get_vect_register_operand(operands[0])
    operand_2 = get_vect_register_operand(operands[1])
    return [op_code, operand_1, operand_2, empty_bits_13]
    
def mov_instruction(op_code, operands):
    if op_code == 'G3_MOVI':
        operand_1 = get_register_operand(operands[0])
        operand_2 = get_immediate_operand(operands[1], 7)
        op_code_bits = to_binary_string(op_code, 5)
        return [op_code_bits, operand_1, operand_2, empty_bits_13]
    else:
        operand_1 = get_register_operand(operands[0])
        operand_2 = get_register_operand(operands[1])
        op_code_bits = to_binary_string(op_code, 5)
        return [op_code_bits, operand_1, operand_2, empty_bits_13]

def branch_instruction(op_code, operands, current_pc, labels):
    if op_code == 'G3_B' or op_code == 'G3_BLT':
        for label in labels:
            if label['label_name'] == operands[0]:
                label_pc = label['pc']
                branch_pc = label_pc - current_pc

                branch_operand = to_binary_string(branch_pc, 19)

                return [op_code, branch_operand]

        raise Exception(
            f'Error: label "{operands[0]}" not found in program.')
    else:
        raise Exception(f'Error: invalid branch instruction "{op_code}"')

def decode_instruction(op_code_key, operands, current_pc, labels):
    try:
        if op_code_key in op_codes['Integer Arithmetic'] or \
           op_code_key in op_codes['Fixed Arithmetic']:
            return arith_instruction(op_code_key, operands)
        elif op_code_key in op_codes['Vectorial Arithmetic']:
            return arith_vect_instruction(op_code_key, operands)
        elif op_code_key in op_codes['Integer Control'] or \
             op_code_key in op_codes['Fixed Control']:
            return control_instruction(op_code_key, operands)
        elif op_code_key in op_codes['Vectorial Control']:
            return control_vect_instruction(op_code_key, operands)
        elif op_code_key in op_codes['General Branch']:
            return branch_instruction(op_code_key, operands, current_pc, labels)
    except Exception as error:
        raise Exception(str(error))

instruction_memory_size = 400
pc = 0
labels = []
instructions = []
try:
    with open("compiled.txt", 'a') as compiled_file:
        for instruction in instructions:
            instruction = instruction.split(' ', 1)

            op_code_key = instruction[0]
            operands = instruction[1].replace(' ', '').split(',')

            instruction_bits = decode_instruction(
                op_code_key, operands, pc, labels)

            print(f'PC: {pc}')
            print(instruction)
            print(instruction_bits)
            print('-------------------------------------')

            for bits in instruction_bits:
                compiled_file.write(f'{bits}\n')
                pc += 1

        while pc < instruction_memory_size:
            compiled_file.write(f'{empty_bits_13}\n')
            pc += 1

except Exception as error:
    print(str(error))
    os.remove("compiled.txt")
    sys.exit(1)

finally:
    compiled_file.close()