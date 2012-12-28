
Plugin Boilerplate for DocPad
=============================

Concept
-------

Plugin for plugins. Boilerplate up to the readme file being generated from package.json or vice-versa whichever has value or else queries the user for information on the commandline.


Rationale
---------

I have found a few docpad plugins to be formatted in a deprecated fashion. Due to DocPad being relatively new, and things in the build/extend/test cycle are bound to change, I found it a good idea to have a plugin generate a boilerplate plugin. This saves me (and others) from copy/pasting manually from the [tutorial](http://bevry.me/learn/docpad-plugin-write) and adds some additional friendliness and clarity for future plugin developers. It also fixes some minor inconsistencies found in the documentation but in case I missed something, pull requests are always welcome!

It is assumed that this plugin is installed by `npm` or cloned through git as a stand-alone tree.

How to use
----------

1. run the script `npm install`
2. answer a few questions on the commandline

Todo
----

1. Wait for a good `pakmanager` like app to generate the package.json for us
