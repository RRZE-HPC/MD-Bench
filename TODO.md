- Cluster Pair
    - Use SIMD for distance calculation when building neighbor lists
    - More than one atom type

- By default, use several atom types (change EXPLICIT\_TYPES option to ONE\_ATOM\_TYPE and set it to false by default)

- Allow to resort atoms at a separate frequency independent of the neighboring
frequency
- Integrate and fix Super-Cluster GPU code
- Consider to also output performance in computed ns per day (a common metric in
the MD world)

* Implement compression of atoms that need to be computed, only execute
arithmetic when register is full

