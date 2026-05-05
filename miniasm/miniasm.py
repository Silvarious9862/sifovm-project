import re
import sys

ROM_DEPTH = 4096
WORD_MASK = 0xFFFF

OPCODES = {
    "INCS":     0b00000001,     # INCS Rn
    "NOT":      0b00000010,      # NOT Rn
    "AND":      0b00000011,      # AND Rn, Rm
    "SRL":      0b00000100,      # SRL Rn
    "MOV_AR":   0b00000101,   # MOV addr, Rn
    "MOV_RA":   0b00000110,   # MOV Rn, addr
    "JMP":      0b00000111,      # JMP addr
    "PUSH":     0b00001000,     # PUSH Rn
    "POP":      0b00001001,      # POP Rn
    "READ_A":   0b00001100,     # READ addr
    "READ_R":   0b00001101,     # READ Rn
    "HLT": 0b11111111,      # HLT
}

'''
INCS Rn 	инкремент по флагу S 	00000001 	1 	Rn = operand1
NOT Rn 	побитовая инверсия 	00000010 	1 	Rn = operand1
AND Rn, Rm 	логическое И 	00000011 	1 или 2* 	Rn = operand1, Rm = operand2
SRL Rn 	логический сдвиг вправо 	00000100 	1 	Rn = operand1
MOV [addr] → Rn 	память → регистр 	00000101 	2 	Rn = operand1, addr = mem_addr
MOV Rn → [addr] 	регистр → память 	00000110 	2 	Rn = operand1, addr = mem_addr
JMP addr 	безусловный переход 	00000111 	2 	addr = mem_addr
PUSH Rn 	занести регистр в стек 	00001000 	1 	Rn = operand1
POP Rn 	извлечь регистр из стека 	00001001 	1 	Rn = operand1
HLT 	останов 	11111111 	1 	операнды игнорируются
'''


def parse_register(token: str) -> int:
    token = token.strip().upper()
    m = re.fullmatch(r"R([0-7])", token)
    if not m:
        raise ValueError(f"Некорректный регистр: {token}")
    return int(m.group(1))

def parse_indirect_reg(token: str) -> int | None:
    """
    Возвращает номер регистра, если token вида "[R4]".
    Иначе возвращает None.
    """
    token = token.strip().upper()
    m = re.fullmatch(r"\[(R[0-7])\]", token)
    if not m:
        return None
    return parse_register(m.group(1))

def parse_number(token: str) -> int:
    token = token.strip()
    if token.lower().startswith("0x"):
        value = int(token, 16)
    else:
        value = int(token, 10)

    if not (0 <= value <= 0x0FFF):
        raise ValueError(f"Адрес вне диапазона 0..4095: {value}")
    return value

def encode_word(addrmode: int, opcode: int, operand1: int = 0, operand2: int = 0) -> int:
    return ((addrmode & 0b11) << 14) | ((opcode & 0xFF) << 6) | ((operand1 & 0b111) << 3) | (operand2 & 0b111)

def assemble_line(line: str):
    line = line.strip()
    if not line:
        return []

    parts = line.split(None, 1)
    mnemonic = parts[0].upper()
    args = parts[1].strip() if len(parts) > 1 else ""

    if mnemonic == "HLT":
        return [encode_word(0b00, OPCODES["HLT"], 0, 0)]

    if mnemonic in ("INCS", "NOT", "SRL", "PUSH", "POP"):
        reg = parse_register(args)
        return [encode_word(0b00, OPCODES[mnemonic], reg, 0)]

    if mnemonic == "AND":
        ops = [x.strip() for x in args.split(",")]
        if len(ops) != 2:
            raise ValueError("AND требует 2 операнда: AND Rn, Rm")
        rn = parse_register(ops[0])
        rm = parse_register(ops[1])
        return [encode_word(0b00, OPCODES["AND"], rn, rm)]

    if mnemonic == "JMP":
    # 1) косвенная через регистр: JMP [R4]
        reg_indirect = parse_indirect_reg(args)
        if reg_indirect is not None:
            # addrmode = 01: адрес берется из регистра Rn = operand1
            return [encode_word(0b01, OPCODES["JMP"], reg_indirect, 0)]

        # 2) прямая: JMP 80 / JMP 0x50
        addr = parse_number(args)
        return [
            encode_word(0b00, OPCODES["JMP"], 0, 0),
            addr
        ]

    if mnemonic == "MOV":
        ops = [x.strip() for x in args.split(",")]
        if len(ops) != 2:
            raise ValueError("MOV требует 2 операнда")

        left, right = ops
        
        # MOV [R4], R7  — косвенная через регистр
        left_indirect = parse_indirect_reg(left)
        if left_indirect is not None and re.fullmatch(r"R[0-7]", right.upper()):
            reg_dst = parse_register(right)
            # здесь уже надо решить, какой addrmode и куда класть регистры
            # например: addrmode=01, operand1=reg_dst, operand2=left_indirect
            return [encode_word(0b01, OPCODES["MOV_AR"], reg_dst, left_indirect)]

        # MOV R7, [R4] — косвенная через регистр
        right_indirect = parse_indirect_reg(right)
        if right_indirect is not None and re.fullmatch(r"R[0-7]", left.upper()):
            reg_src = parse_register(left)
            # addrmode=01, operand1=reg_src, operand2=right_indirect
            return [encode_word(0b01, OPCODES["MOV_RA"], reg_src, right_indirect)]

        # MOV [addr], Rn   (как раньше)
        if re.fullmatch(r"R[0-7]", right.upper()):
            addr = parse_number(left)
            reg = parse_register(right)
            return [
                encode_word(0b00, OPCODES["MOV_AR"], reg, 0),
                addr
            ]

        # MOV Rn, [addr]   (как раньше)
        if re.fullmatch(r"R[0-7]", left.upper()):
            reg = parse_register(left)
            addr = parse_number(right)
            return [
                encode_word(0b00, OPCODES["MOV_RA"], reg, 0),
                addr
            ]

        raise ValueError(f"Неподдерживаемая форма MOV: {line}")
    
    if mnemonic == "READ_A":
        # READ_A addr  -> двухсловная команда, addr во втором слове
        addr = parse_number(args)
        word1 = encode_word(0b00, OPCODES["READ_A"], 0, 0)
        return [word1, addr]

    if mnemonic == "READ_R":
        # READ_R Rn -> однословная команда, номер регистра в operand1
        reg = parse_register(args)
        word1 = encode_word(0b00, OPCODES["READ_R"], reg, 0)
        return [word1]

    raise ValueError(f"Неизвестная команда: {mnemonic}")

def assemble_text(program_text: str):
    rom = []
    trace = []  # для каждого слова – исходная строка
    lines = program_text.splitlines()

    for line_no, raw_line in enumerate(lines, start=1):
        line = raw_line.strip()

        if not line:
            continue

        try:
            words = assemble_line(line)
        except Exception as e:
            raise ValueError(f"Ошибка в строке {line_no}: {e}")

        if len(rom) + len(words) > ROM_DEPTH:
            raise ValueError("Программа не помещается в ROM 4096 слов")

        rom.extend(words)
        trace.extend([raw_line.rstrip("\n")] * len(words))  # одна строка → 1 или 2 слова

    return rom, trace

def print_rom(rom, trace):
    for addr, value in enumerate(rom):
        word = value & WORD_MASK
        bits = format(word, '016b')

        addrmode = bits[0:2]
        opcode   = bits[2:10]
        operand1 = bits[10:13]
        operand2 = bits[13:16]

        src = trace[addr] if addr < len(trace) else ""

        print(f"{addr:04d}: {word:5d}  {addrmode} {opcode} {operand1} {operand2}   ; {src}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Использование: python miniasm.py program.txt")
        sys.exit(1)

    with open(sys.argv[1], "r", encoding="utf-8") as f:
        program_text = f.read()

    rom, trace = assemble_text(program_text)
    print_rom(rom, trace)