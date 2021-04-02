Modules
=======

The feature of Squl which allows for "programming in the large" is modules. Modules allow code to be organised into reusable components. They also have many other uses, such as caching often used deductions (memoizing) and separating the run-time state of an application from it's implementation.

A module is a collection of statements. Conversely, all statements must be in a module. 

A module can have "import links" to other modules, allowing it to re-use functionality defined in other modules. Not all statements in a module are visible to other modules. Only those statements marked as "exported" will be usable by other modules. This allows for encapsulation.

Each module has metadata inside it (encoded as statements of the form "module:_ metadata:_"). Metadata includes a name, an author, a creation date and links to other modules.

Modules can be published for other users to download. Modules can be mutable (editable) or read-only; they must be read-only in order to be published for others to use. If a module is being actively worked on, it is mutable.

Module imports are for a particular version of a module. If a module is edited and re-exported, it is considered to be a new module. Any imports of this module will need to be updated to import the new version instead of the old version. This entails that the onus is on the programmer to update the dependencies of a module to their respective latest versions, rather than on the user. This guarantees that a module will execute with exactly the same dependencies that it was developed and tested in. 

Faish provides a user interface to find and load modules from remote servers. When a module is loaded, its dependencies are also loaded automatically.

Module importing
----------------

Modules are the basis for creating reusable components in Squl. A one-way link can be made between modules to allow one module to use statements in another module. This link is referred to as a "module import". This is usually facilitated by the user interface; in Faish, the user can browse other available modules and add imports using a simple dialog box.

To create an import in a module, press CTRL+i, select the module you want to import and click "Add Import". This adds another metadata statement to your module.

The metadata that defines module imports are of the form::

    module:M metadata:(import:ImportedModule uri:URI name:Name).

where M is the current module, ImportedModule is the imported module, URI is the location of the imported module on the Internet and Name is only informative. Here, M and ImportedModule are special built-in data types called "module literals". These literals have special behaviour when exported to a file. The URI is only used if the imported module cannot be found in local repositories. The "tab" character is used as the specifying character for module literals; it is not intended that users manually edit them but rather that users use the GUI tools to manage module literals.

Note that "importing" a module only adds this metadata statement as a link to another module; it does not physicially add any other statements to your module.

After a module has been imported (i.e. a link has been made), not all statements in the imported module are available. Statements need to be exported first. Statements are made visible to other modules by including an export template in a module:

    export:(...statement signature...).

For example, if a statement contained a lot of parent-child relationships, they can all be made available in this way::

   export:( parent:_ of:_ ).
   parent:alice of:bob.
   parent:bob of:charles.

The variables in an export-clause are only placeholders; any statement which matches with the given sub-statement will be made available to other modules.

For every query and deduction step, the following modules are searched.

* The current module for this step in the deduction.
* Exported statements in the modules imported by the current module.
* The root module
* Exported statements in the modules imported by the root module.

The root module is the module where queries originate, and the current module is somewhere on a chain of imports from the root module.

The motivation behind making all statements in the root module visible is that this is a common way of structuring an application. For interactive applications, there is a mutable "working module" which continuously has input and output data added to it. This "working module" is the root module from which queries are made, and it imports "implementation" modules that implement its functionality. 

If-then clauses get special treatment. The "then"-clause will match the exported statement signature. Results for the "if"-clauses are searched in the usual way: the current module is searched, the current module's imports are searched, the root module is searched and the root module's imports are searched.

For example::

   export:( grandparent:U of:V ).
   
   then:( grandparent:X of:Z )
       if:( parent:X of:Y )
       if:( parent:Y of:Z ).
   
   parent:alfred of:bob.
   parent:bob of:charles.

If a module *importing* this module queries for "grandparent:U of:V?", it will find "grandparent:alfred of:charles.". 

Here, matches for "parent:_ of:_" are found in the same module, but could have also have been found as exported statements from an imported module, in the root module, or as exported statements from an import from the root module. 

A module doen not have visibility into modules that import it. If the *importing* module defines some "parent:X of:Y." relationships, these will be ignored by the if-then rule defined in the imported module (unless the *importing* module is not the root module).
    
In order for an importing module to use the if-then rules of an imported module, those if-then rules need to be exported::

   (module A, imports module B)
   ...lots of parent:X of:Y rules...

   (module B)
   export:( then:(grandparent:X of:Y) if:A if:B ).
   then:( grandparent:X of:Z )
   if:( parent:X of:Y )
   if:( parent:Y of:Z ).

In this case, a "grandparent:X of:Y?" query on module A will succeed in returning results based on the parent relationships in module A.

One last special case is if your module is a "test" module containing tests for a "target" module. It can see all statements in that "target" module. This is used only for writing unit tests.


Examples
--------

Say that:

* Module "root" imports "a",
* module "a" imports "b"

"root" has the following statements::

    e:m f:n.

"a" has the following statements::

    export:( a:_ ).
    a:a.
    export:( a:_ b:_ ).
    then:( a:X b:Y )
        if:( c:X d:Y ).

"b" has the following statements::

    export:( c:_ d:_ ).
    then:( c:X d:Y )
        if:( e:X f:Y ).
    c:o d:p.

The query "e:X f:Y?" on the root module will return:

    e:m f:n.

because it is only declared in the root module and not exported by any of root's imports.

The query "a:X?" on the root module will return:

    a:a.

because module "a" exports "a:_", and the search in module "a" will only find "a:a." in itself.

The query "a:X b:Y?" on the root module is non-trivial. Remember that at each step, the seach looks in the current module, the current module's imports, the root module and the root module's imports:

# Nothing is found in the root module, so the search moves to imports from the root module.
# "a:_ b:_" is exported by module "a", so module "a" is searched.
# The search finds the "if-then" statement in module "a" and starts looking for "c:X d:Y".
# "c:X d:Y" returns no results in module "a", so it's imports are searched.
# "c:_ d:_" is exported by module "b". Module "b" is searched, and finds "c:o d:p" which is returned as one result. The search continues for more results.
# The search finds the "if-then" rule in module "b" and starts searching module "b" for "e:X f:Y".
# "e:X f:Y" is not found in module "b" or in module "b"'s imports (there are none), so the root module and the root module's imports are searched.
# "e:m f:n" is found in the root module.
# The search unravels and returns the result "a:m b:n" from the root module.

Resulting in:

    a:o b:p.
    a:m b:n.

Manipulating modules in code
------------

TODO: move this to a "reflection" chapter?

Modules are an excellent way to create complex data types in Squl. There are two ways of manipulating modules: using the timeline (TODO: not implemented) and directly. You must use the timeline if you want to parallelise access to modules or use the transaction API.

Modules act like non-indexed, non-sorted collections of statements and respect a similar API as collections.

A query on a module returns a results collection, which can also be used just like an immutable module.

Note that source code is held separately from statements inside the module. Source code for a module is stored in an adjacent source code module created for that purpose. As a result, a module's statement labels, atoms and variables are not stored in a human readable format. If you want a human readable format, you must query the source code module attached to that module.

TODO

    create:module result:New.
    module:M add:Statement result:R.
    module:M remove:Statement result:R.
    module:M union:Another result:R.
    module:M intersection:Another result:R.
    module:M difference:Another result:R.
    module:M map:Fn result:R.
    module:M aggregate:Fn result:R.
    module:M do:Fn inject:Injection result:Result.


Repositories
------------

To find and download modules, repositories are used. Repositories can be either a directory (folder) on the local computer, or a directory on a remote web server. Every file in a repository is a standard text file encoded in UTF-8, readable in a standard text editor.

TODO: adding and removing repositories.

Within a repository's directory, there is a file called "index.faish" (TODO: check this). This is a special exported module which contains metadata of all other exported modules in this directory. When you add a repository to your local Faish environment, this file is read in and used to determine what is available at that repository.

The other files in the repository are exported modules. Their file names are generated by creating from the MD5 digest of the module contents. This is used as a unique identifier for the module rather than to prevent malicious intent; MD5 is known to be insecure. Conveniently, it is also used as a checksum to ensure modules have not been accidently altered en route, although an altered module will still load with only warnings being presented to the user. This means that files can be repaired manually with a text editor in times of duress.

TODO: how do you regenerate index.faish?

Module export file format
-------------------------

Modules can be exported to a file and imported again later or into another Squl implementation. The file format is a standard text file using UTF-8.

A module file starts with the following header. The size is the number of bytes in the contents of this module export::

    Application/vnd.squl1 ModuleExport size=280

Following this header is a line for every module literal found in the rest of the module. Each line is a unique "handle" for the module literal, followed by a colon and then the MD5 digest of the contents of that module. The first module in the list is always this module::

    mP064:5F426E0C527935F186A676B07D925047
    mP0510:60104C1A5630670B50BA22D7A258099D

Module handles are only used for exporting and importing modules, and only within the same file. Once loaded into a Squl interpreter, imported modules are loaded and module literals will then contain actual memory references to the imported modules.

This concludes the header of the exported module. A separator is used to separate the header from the contents::

    --

Finally, the contents of the module, from which the MD5 digest is derived, is appended. Statements are stored in a sorted order within the file to ensure that the file will work well with version control tools::

    metadata:( name:["P06] ) module:[       mP064].
    
    metadata:( importModule:[       mP0510] name:["P05] uri:unknown ) module:[      mP064].

    if:(list:X reversed:X)
    then:(palendrome:X).

Each statement is separated by a newline character. Module literals use a tab character as their specifier and then the handle of the module used, as defined in the header of the file.


Manually writing a module file
-------------------------

It's possible to write a module file in your favourite text editor or IDE and then import it into Faish. To do this, start with the following heading::

    Application/vnd.squl1 ModuleExport size=280
    --

Below the two dash characters, write your statements. When you import this file into Faish, you will get a warning about the size being invalid. (TODO: implement this check). The file will continue to be imported, even if there are errors in the statements.

If errors are found, these are included as (syntaxError:_ position:_) statements, which you can edit in Faish to resolve. 

It's not practical to manage imports and module metadata in a text editor. Rather, add comments in the file in the format (comment:_) to document module metadata and revisit the file after it has been imported into Faish.


