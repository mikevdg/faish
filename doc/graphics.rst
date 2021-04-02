Graphics and User Interaction
=============================

Faish provides two ways to interact with the user: a simple command-line interface, and a canvas-based graphics API. The command-line allows a user to enter some text and for Faish to respond to that text. The canvas interface (as of 0.2, incomplete) allows for basic two dimensional graphics.

All input and output in Faish is done using tocks. 

Tocks
---------------

A module contains statements which are considered to be true, for all time. In order to account for changes in the state of any object, timestamps must be added to every statement which declares something about the state of an object. In other words, you say an object can have a property or state, but only at a certain time or for a period of time. This also applies to actions; actions happen at a particular time.

A tock is a point in time. It is, in effect, a timestamp, except that the timing itself is not necessarily recorded. Each tock has another tock preceeding it (except for the first tock) and a tock following it (except for the latest tock). These are defined using the following relationship, which defines Tock1 to preceed Tock2::

   tick:Tock1 tock:Tock2.

Working Modules
---------------

When a command line or graphics interface is presented to the user, a "working module" is made. A working module is a module containing all of the working information about the user interface: what was interacted with, where, when, and which order these events are in. The working module will be discarded when the user interface is closed.

The working module has an import to your implementing module. You define the behaviour you want in a module, and when you open it, Faish will create a working module and add your module as an import.

The user interface receives events from the user such as mouse and keyboard clicks. For each event, the following happens:

# A new tock is created and added to the working module with its relationship to the previous tock::

    tick:t1 tock:t2.

Information about the event is then added to the working module::

    device:canvas tock:t1 event:(event:leftMouseButtonReleased x:[+197] y:[+134]).

The environment then performs the query::

    device:canvas tock:Tock render:Render?
	(TODO: device:tock:action?)

This query is performed, and the value of Render is treated as a command for the user interface to perform. 


Command-line Interface
----------------------

The command-line interface is intended for simple applications which just want basic interactivity.

To enable the command line interface, include the following statements in your module::

    device:cli title:["My command line application].
    export:( device:cli output:_ tock:_ ).   

You can replace the title with whatever you want the window title to be.

Whenever the user enters a sentence on the command line, a statement such as this will be injected into the working module, as well as the tock relationship::

    device:cli input:["asdf] tock:t0.
    tick:t0 tock:t1.

where the string literal is the text that the user typed in.

You then need to implement logic to respond to queries of this signature::

    device:cli output:Output tock:Tock?

where X is a string to present to the user in responce to the user's input. 

For example, to respond "No" to everything the user enters:

    device:cli output:["No.] Tock:_.


Canvas interface
----------------

The canvas is a naive two-dimensional event and drawing API. Events from the user are timestamped with a tock and injected into the working module. A query is then performed to determine what to render. Currently it only supports three types of graphic: text, line and rectangle, and has no support for colour other than a highly attractive cyan background.

Note that future versions of Faish will use a different coordinate system for the canvas. Don't invest too much effort in your graphical applications yet! The current version is to test the viability of graphics in a declarative programming language.

For now, coordinates use pixels as the coordinate system with (0,0) at the top left corner and increasing in value towards the bottom right corner. The window is completely redrawn after each tock; the module logically describes only the state of the canvas at a particular tock and does not need to concern itself with any drawing commands from previous tocks or cleaning up any old artifacts on the window.

In order to enable the canvas, you need to add these statements to your module::

    device:canvas title:["My Canvas demonstration].
    export:( device:canvas tock:_ render:_ ).

where the string literal is whatever you want the window title to be.

You can then write logic to answer the following queries::

    device:canvas tock:_ render:( 
        shape:text 
        text:["This is some text] 
        topLeft:( x:[+10] y:[+10] ) ).

    device:canvas tock:_ render:( 
        shape:line 
        topLeft:( x:[+30] y:[+30] )
        bottomRight:( x:[+60] y:[+40] )).

    device:canvas tock:_ render:( 
        shape:rectangle
        topLeft:( x:[+10] y:[+60] )
        bottomRight:( x:[+60] y:[+70] )).

for some text, a black line and a black rectangle respectively. You can specify as many render statements for a tock as you want, and all the shapes will be rendered on the canvas for that tock.

You will discover events that are occuring by opening up the working module. This can be accessed from a menu on the canvas. For example::

    device:canvas tock:t44 event:(event:leftMouseButtonPressed x:[+183] y:[+227]).

As of Faish 0.2, the only events available are mouse button clicks. Keyboard input will be added later.


Future plans
----------------

It is envisenged that a future release of Faish will have a more capable canvas interface. However, the developmental priorities at the moment are to extract some semblance of intelligence from Faish before adding bells and whistles.

The long term plan is to implement a Squl IDE entirely using the canvas interface, with widgets and all the interactive components all implemented in the Squl language. This is, however, a massive undertaking.

An improved coordinate system would use micrometers, with the pixel pitch of the current display available to the application so that pixel-accurate rendering is still viable. The current industry trend is for displays to increase in pixel density such that pixel density now varies wildly between technologies.

An improved canvas would have all the drawing commands we are familiar with from other graphics APIs. A text rendering API will probably be provided as part of the canvas interface, despite it's complexity.

The concept of a "subcanvas" could be introduced. A subcanvas is a canvas on top of another canvas: it has it's own event loop and renders independently of its parent canvas. If a canvas is busy (the query has not yet returned results for the current tock), it is rendered with some "busy" icon. Subcanvases can thus continue to be interactive even though a parent or child canvas is busy, and would also allow for the use of multithreading.

