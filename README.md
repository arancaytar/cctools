cctools
=======

These are some Lua scripts for use within the Minecraft expansion ComputerCraft, 
mostly aimed at turtle control.

Getting these scripts onto a computer (specifically a turtle) will require some more or less awkward fiddling.
The easiest way may be to upload the file to pastebin and then use ComputerCraft's built-in pastebin client to
download it.

On a local server, you can locate the disk folder of the target computer and copy the files directly.

Failing all these, you can attempt to copy-paste the script, but this works poorly.

Note: All scripts should be placed into a subfolder named "aran/" on the computer.

Features
--------

The most useful part here is the "build" script, which can take a text file (filled with spaces and # characters),
and reproduce it in blocks, in a manner resembling a 3D printer.

* The top-left corner of the pattern is positioned directly underneath the turtle's starting position.
* The first row of the pattern is aligned with the turtle's initial orientation.
* A functioning GPS signal must cover the entire area the turtle is to operate in. GPS satellites (consisting of four
  computers with wireless modems) are relatively easy to set up.
  
    usage:
      build <patternfile> <number of layers>

The turtle assumes and requires its maneuvering layer (directly above the build layer) to be free of obstructions, and
multiple layers must be placed bottom to top. Each turtle can only build with one material (turtles cannot recognize
multiple materials, and the pattern format can't encode them). Multiple turtles might build a more complex structure
in several passes, provided they do not obstruct each other.
