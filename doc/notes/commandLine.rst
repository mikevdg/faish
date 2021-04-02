Command Line device
==============================

This is a proposed device which can do:

* Use stdin, stdout, stderr.
* Have access to command line parameters.
* Read / write files.
* Quit the command line interface.

It would be a small executable that would connect to a Faish server, probably using a named pipe or TCP connection.


The executable
-----------------------

::
    faish [OPTIONS] MODULE_ALIAS [MODULE_PARAMS]

This would connect to the Faish server, create a new working module and add the module referred to by [MODULE_ALIAS] as an import. Then it would begin the event loop.

For now, we assume the connection is made using a well-known named pipe.

[MODULE_PARAMS] are passed to the module as command line parameters.

Environment variables are copied into the working module as (env: value:).

[OPTIONS] can have::

    -m --may-access-files
        Allow the Faish module to do file operations.
    
    -l --list
        List all available module aliases and their description.
    
    -h --help
        Show help for this module.

stdio
----------------------

::
    device:stdio tock:~ event:( read:Char ).
    device:stdio tock:~ action:( write:Char ).
    device:stdio tock:~ action:( error:Char )

(maybe read and write strings instead?)
(TODO: what about error handling?)


TODO

    device:D 
    tock:Tk 
    contextIn:CBefore
    contextOut:CAfter
    action:A?

    device:D class:stdio.
    
    device:D
    tock:Tk
    context:(before:M after:N)
    action:A.

Command line parameters
-----------------------

These would be added to the working module as a list of strings
::

    parameters:~.

Each parameter would be described using these metadata. These would be printed out when -h is used.

    metadata:( name:~ ).
    metadata:( alias:~ ).
    metadata:( description:~ ).
    metadata:( parameter:~ short:~ description:~ ).


Reading and writing files
--------------------------

TODO: Needs error handling. Needs writing parts of a file, append mode, lots more.


Error handling can be done using events. Errors can be managed in the same way as other events.

::
    device:stdio tock:~ action:( openFileNamed:~ file:~ ).
    device:stdio tock:~ action:( closeFile:~ ).
    device:stdio tock:~ action:( readWholeFile:~ ).
    device:stdio tock:~ event:( file:~ contents:~ ).
    device:stdio tock:~ action:( writeWholeFile:~ contents:~ ).


Quitting the command line interface
-----------------------------------

TODO: allow clean up code to run on disconnect.

This action will terminate the executable and close the connection with the server.

::
    device:stdio tock:~ action:quit.


