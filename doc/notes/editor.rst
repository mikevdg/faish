A new editor
-------------------

* Implement it in Squl.
* Use a canvas API.

Using a canvas means it can be easily ported to other platforms.

Features:

* Edits individual statements.
* Shows compiler errors inline.
* Shows documentation and statement metadata nicely.
* Shows something when source code is not available.
* Searches for statements.
* Searches for text fragments anywhere.
* Manages queries (which are statements): add, edit, run, stop, re-run, make test.
* Manages tests. Can run tests.
* Manages imports. You can search for modules and add imports. You can upgrade imports.
* Is a debugger. It can show a call stack and controls a cursor in the editor.
* Can handle large 'database' modules that don't fit in memory.
* Bookmarks?

A module looks like this; it's basically a big tree:

Title
Module docs
Module metadata, imports
Exports.
Statements. For each statement:
	- statement signature and doc
	- statement metadata (collapsed by default)
	- implementation (including compiler errors, breakpoint locations)
	- tests (including current running state)
		- test results.
	- queries (aka tests that only survive the session) (including current running state)
		- query results.

Each of the above is a "paragraph". A paragraph is a text area. Paragraphs are stacked on top of each other. 

No line wrapping needs to be done. This is done by the user or automatic code formatter.

The editor's state has:
- Visible text window (from which line to which line)
- Cursor location
- Currently selected text.
- Any modal state? Whether "insert" is on or off? Caps lock? Scroll lock?
- Where we are for debugging? Which of the running queries we are debugging.
- The current "statement definition" for going to the next one.
- Current search text.

The areas of the screen which need to be animated are the cursor, test results and query results.

(Maybe scroll lock can convert the window from edit to read-only).

Keyboard shortcuts:

* New statement CTRL-n
* Delete statement CTRL-d
* New query / test CTRL-e
* Remove query / test / all queries. CTRL-del
* Go to matching bracket CTRL-[
* Incremental search (nah. Just make ordinary search fast).
* Search / replace CTRL-f, CTRL-g
* Go to next search result. CTRL-j, CTRL-k??? F3? CTRL-pgdown?
* Go to previous search result. CTRL-p
* Replace this text. CTRL-h
* Replace all instances. CTRL-a
* Go into definition of statement at cursor. CTRL-.
	- If on a literal selector, go to that instead.
* Go to next (or prev) definition of the definition we just went to. Same as go to next search result.
* Reformat CTRL-i 
* Go to next statement. CTRL-down
* Go to previous statement. CTRL-up
* Save changes CTRL-s
	- Commit changes? How would this work?
* Show auto-completion? CTRL-space
* Go to next error
* Go to parent statement. (?)

Debugging shortcuts:
* Go wide
* Go deep
* Go back to parent
* Go back to previous result (of a UnificationSearchable)
