import sys
import re

if len(sys.argv) != 5:
    print("Usage: python preds.py <iaca> <mca> <osaca> <uica>")
    sys.exit(1)

iaca_pred = float(sys.argv[1])
mca_pred = float(sys.argv[2])
osaca_pred = float(sys.argv[3])
uica_pred = float(sys.argv[4])
preds = [iaca_pred, mca_pred, osaca_pred, uica_pred]

start = -4.0
end = 36.0
npoints = 50
offset = (end - start) / (npoints - 1)
i = 0
for pred in preds:
    print(f"@target G0.S{i+6}")
    print(f"@type xy")
    for j in range(npoints):
        pos = start + offset * j
        print("{:.6f} {}".format(pos, pred))

    print("&")
    i += 1
