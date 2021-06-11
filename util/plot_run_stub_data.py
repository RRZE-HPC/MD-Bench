import matplotlib.pyplot as plt
import sys

vector_width = 8 # 8 doubles per zmm vector

filename = sys.argv[1]
output_file = filename.replace(".txt", ".pdf")
fig = plt.figure()
ax = plt.axes()
plot_data = {}

with open(filename, 'r') as fp:
    for line in fp.readlines():
        steps, unit_cells, atoms_per_unit_cell, total_atoms, total_vol, atoms_vol, neigh_vol, time, atom_upds_per_sec, cy_per_atom, cy_per_neigh = line.split(',')
        atoms_per_unit_cell = int(atoms_per_unit_cell)
        vol = float(neigh_vol)
        cy_per_atom = float(cy_per_atom)

        if atoms_per_unit_cell < 2048:
            if atoms_per_unit_cell not in plot_data:
                plot_data[atoms_per_unit_cell] = {}

            cy_per_iter = cy_per_atom * vector_width / atoms_per_unit_cell
            plot_data[atoms_per_unit_cell][vol] = cy_per_iter if vol not in plot_data[atoms_per_unit_cell] \
                                                  else min(cy_per_iter, plot_data[atoms_per_unit_cell][vol])

for atoms_per_unit_cell in plot_data:
    volumes = list(plot_data[atoms_per_unit_cell].keys())
    volumes.sort()
    cycles = [plot_data[atoms_per_unit_cell][vol] for vol in volumes]
    ax.plot(volumes, cycles, marker='.', label=str(atoms_per_unit_cell))

ax.vlines([32, 1000, 28000], 0, 1, transform=ax.get_xaxis_transform(), linestyles='dashed', color=['#444444', '#777777', '#aaaaaa'])
ax.set(xlabel='Neighbor data volume (kB)', ylabel='Cycles per iteration')
ax.set_xscale('log')
#ax.set_xticks([32, 1000, 28000])
#ax.set_xlim(0, 200000)
plt.legend(title="atoms/uc")
fig.savefig(output_file, bbox_inches = 'tight', pad_inches = 0)
