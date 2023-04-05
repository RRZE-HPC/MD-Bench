import sys
import re

if len(sys.argv) != 6:
    print("Usage: python preds.py <iaca> <mca> <osaca> <uica> <div_factor>")
    sys.exit(1)

iaca_pred = float(sys.argv[1])
mca_pred = float(sys.argv[2])
osaca_pred = float(sys.argv[3])
uica_pred = float(sys.argv[4])
div_factor = float(sys.argv[5])
preds = [x / div_factor for x in [iaca_pred, mca_pred, osaca_pred, uica_pred]]

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
