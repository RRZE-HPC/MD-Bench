import sys
from cachesim import CacheSimulator, Cache, MainMemory

def get_set_id(cache, addr):
    return (addr >> cache.cl_bits) % cache.sets

filename = sys.argv[1]
N = sys.argv[2]
mem = MainMemory()

# Cascade Lake
l3 = Cache("L3", 14336, 16, 64, "LRU", write_allocate=False)
l2 = Cache("L2", 1024, 16, 64, "LRU", store_to=l3, victims_to=l3)
l1 = Cache("L1", 64, 8, 64, "LRU", store_to=l2, load_from=l2)
mem.load_to(l2)
mem.store_from(l3)
cs = CacheSimulator(l1, mem)

sets_hist = {
    'l1': {s: 0 for s in range(l1.sets)},
    'l2': {s: 0 for s in range(l2.sets)},
    'l3': {s: 0 for s in range(l3.sets)}
}

with open(filename, 'r') as fp:
    for line in fp.readlines():
        op, addr = line.split(": ")
        op = op[0]
        addr = int(addr, 16)
        sets_hist['l1'][get_set_id(l1, addr)] += 1
        sets_hist['l2'][get_set_id(l2, addr)] += 1
        sets_hist['l3'][get_set_id(l3, addr)] += 1

for cache_level, data in sets_hist.items():
    if cache_level != 'l3':
        print(cache_level, ": ")
        for set_id in data:
            if data[set_id] > 0:
                print(set_id, " -> ", data[set_id])
