import sys
import re

if len(sys.argv) != 2:
    print("Usage: python string_to_agr.py input_filename")
    sys.exit(1)

input_filename = sys.argv[1]
result_list = []

with open(input_filename, 'r') as file:
    for line in file:
        numbers = re.findall(r'\d+\.\d+', line)
        divided_numbers = [float(number) / 8 for number in numbers]
        result_list.append(divided_numbers)

start = -2.5
bar_offset = 1.0
group_offset = 8.0
i = 0

for group in result_list:
    print(f"@target G0.S{i}")
    print(f"@type bar")

    j = 0
    for meas in group:
        pos = start + i * bar_offset + j * group_offset
        print(f"{pos} {meas}")
        j += 1

    print("&")
    i += 1
