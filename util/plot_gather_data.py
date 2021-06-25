import matplotlib.pyplot as plt
import sys

filename = sys.argv[1]
output_file = filename.replace(".txt", ".pdf")
fig = plt.figure()
ax = plt.axes()
plot_data = {}

status = 0 # No header found
md_case = False
stride = None
dims = None
freq = None
cl_size = None
vector_width = None
cache_lines_per_gather = None

with open(filename, 'r') as fp:
    for line in fp.readlines():
        line = line.strip()

        if len(line) <= 0:
            continue

        if line.startswith("Stride,"):
            status = 1
            md_case = True if "Dims" in line else False
            continue

        if line.startswith("N,"):
            status = 2
            continue

        assert status == 1 or status == 2, "Invalid input!"

        if status == 1:
            if md_case:
                stride, dims, freq, cl_size, vector_width, cache_lines_per_gather = line.split(',')
            else:
                stride, freq, cl_size, vector_width, cache_lines_per_gather = line.split(',')

            stride = int(stride)
            continue

        if md_case:
            N, size, total_time, time_per_it, cy_per_iter, cy_per_gather, cy_per_elem  = line.split(',')
        else:
            N, size, total_time, time_per_it, cy_per_gather, cy_per_elem  = line.split(',')

        size = float(size)
        cycles = float(cy_per_iter) if md_case else float(cy_per_gather)

        if stride not in plot_data:
            plot_data[stride] = {}

        plot_data[stride][size] = cycles if size not in plot_data[stride] \
                                  else min(cycles, plot_data[stride][size])

for stride in plot_data:
    sizes = list(plot_data[stride].keys())
    sizes.sort()
    cycles = [plot_data[stride][size] for size in sizes]
    ax.plot(sizes, cycles, marker='.', label=str(stride))

cy_label = "Cycles per iteration" if md_case else "Cycles per gather"
ax.vlines([32, 1000], 0, 1, transform=ax.get_xaxis_transform(), linestyles='dashed', color=['#444444', '#777777'])
#ax.vlines([32, 1000, 28000], 0, 1, transform=ax.get_xaxis_transform(), linestyles='dashed', color=['#444444', '#777777', '#aaaaaa'])
ax.set(xlabel='Array size (kB)', ylabel=cy_label)
ax.set_xscale('log')
#ax.set_xticks([32, 1000, 28000])
#ax.set_xlim(0, 200000)
plt.legend(title="Stride")
fig.savefig(output_file, bbox_inches = 'tight', pad_inches = 0)
