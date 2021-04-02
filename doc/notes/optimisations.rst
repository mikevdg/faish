Optimisations in Faish
======================

The current plan is to compile to machine code via LLVM. Also investigate:

* Use SIMD

* Multi-thread everything.

* Use MPI

* Compiling to OpenCL or SPIR-V.

* Compiling to FPGA via perhaps VHDL or an intermediate hardware language if one can be found.


The biggest gains will come from algorithm and data structure choice, memoization of results, choosing good hints.

Merge UnificationSearchable and ImportListSearchable.

Some parts of the search stack can be discarded. Only the 'parent' needs to be kept. 

If a DeductionSearchable is investigated in a fixed monotonic order, then it's child UnificationSearchables can "return" to the same parent rather than make more children. Variables can be shared and re-used if only one value ever needs to be kept. For each of the DeductionSearchable's if-clauses, we'd need to know which variables have had their values fixed by a previously investigated clause.

If backtracking isn't going to happen, variable values can be made mutable.

If you have::

    ~ :-
         array:X index:[+1] insert:foo result:Y,
         ~,
         array:Y index:[+8] insert:foo result:Z,
         ~.

These two statements could be done concurrently on a shared mutable array if the compiler can prove they would not interfere with each other.

For concurrent code, only fork a process if useful. Perhaps two code paths could be made - one for forking, one for not forking (because not forking might enable more optimisations).

Statements can be re-written in several ways (and all these re-writes can be applied in reverse):

* if-clauses can be inlined; each match can be pre-unified creating a new then-if statement.

* Memoized results can be inlined into if-clauses..

* Unused variables can be elided if a result can be proven to be found.

Built-ins, of course, should be inlined.

The outer event loop should be turned into code and seamlessly compiled in to generated code from its queries.

If no results for an if-clause can ever be found, that then-if statement can be disregarded.

Recursion needs to be converted into loops.


