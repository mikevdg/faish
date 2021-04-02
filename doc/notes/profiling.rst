Profiling
==============

When profiling, we want to see these statistics:

* # of deductions
* % time wasted backtracking
* % time wasted in aborts
* % time wasted deriving duplicated results
* % time in negation searches
* % time evaluating hints
* # of (possible|actual) threads over time.
* Amount of idle time on other cores / nodes
* Amount of time waiting for data (from disk / net / other thread)


* Info about compiler optimisations
* Total deductions under each branch (in the debugger?)
* Loop detection results

* Bring in low-level profiling stats (cache misses, etc)

Display statistics as:

* Totals
* Over time
* Per thread
* Per deduction

