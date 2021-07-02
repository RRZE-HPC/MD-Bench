import sys
from cachesim import CacheSimulator, Cache, MainMemory

filename = sys.argv[1]
mem = MainMemory()

#l3 = Cache("L3", 20480, 16, 64, "LRU")  # 20MB: 20480 sets, 16-ways with cacheline size of 64 bytes
#l2 = Cache("L2", 256, 4, 64, "LRU", store_to=l3, load_from=l3)  # 256KB
#l1 = Cache("L1", 64, 8, 64, "LRU", store_to=l2, load_from=l2)  # 32KB

# Cascade Lake
l3 = Cache("L3", 14336, 16, 64, "LRU", write_allocate=False)
l2 = Cache("L2", 1024, 16, 64, "LRU", store_to=l3, victims_to=l3)
l1 = Cache("L1", 64, 8, 64, "LRU", store_to=l2, load_from=l2)
mem.load_to(l2)
mem.store_from(l3)
cs = CacheSimulator(l1, mem)

with open(filename, 'r') as fp:
    for line in fp.readlines():
        op, addr = line.split(": ")
        op = op[0]
        addr = int(addr, 16)

        if op == 'W':
            cs.store(addr, length=8)
        elif op == 'R':
            cs.load(addr, length=8)
        else:
            sys.exit("Invalid operation: {}".format(op))

cs.force_write_back()
cs.print_stats()
