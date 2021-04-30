You're looking at the source code for Faish, which is an implementation 
of the Squl programming language.

The website for this project is http://www.squl.org/

Faish is implemented using VisualWorks Smalltalk, 
http://www.cincomsmalltalk.com/; download the "Personal Use License" 
version.

To start up Faish, file in the source code into VisualWorks (open a 
"file browser") in this order:

Faish.st
   (then, in the debugger, execute "FaishVariable initialize", then restart the 
    second context from the top of the list. I will fix this eventually. )
Faish-Exceptions.st
Faish-UserInterface.st
Faish-UserInterface-DeductionBrowser.st

Then execute in a workspace:

FaishModuleListUI open.

Then go read the documentation in /doc. This documentation uses 
Sphinx-doc, http://sphinx-doc.org/ and is perfectly readable without 
processing.
