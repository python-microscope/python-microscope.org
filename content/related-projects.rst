.. Copyright (C) 2020 David Miguel Susano Pinto <david.pinto@bioch.ox.ac.uk>

   This work is licensed under the Creative Commons
   Attribution-ShareAlike 4.0 International License.  To view a copy of
   this license, visit http://creativecommons.org/licenses/by-sa/4.0/.

Related Projects
****************

Microscope is a relatively recent software.  It is in use in the
following projects (sorted alphabetically).


BeamDelta
=========

`BeamDelta <https://pypi.org/project/BeamDelta>`_ is a tool to help
align optical systems.  It greatly assists in assembling bespoke
optical systems by providing a live view of the current laser beam
position and a reference position.  It uses Microscope for the camera
control component.


Cockpit
=======

`Cockpit <https://github.com/MicronOxford/cockpit/>`_ is Microscope's
sister project, an easy to use control GUI aimed at biologists.


CryoSim
=======

Microscope, in conjunction with Cockpit, is the software used to
control `CryoSIM <https://doi.org/10.1364/OPTICA.393203>`_, a
microscope for 3D super-resolution fluorescence cryo-imaging for
correlation with cryo-electron microscopy or cryo-soft X-ray
tomography.


DeepSIM
=======

The forever under development DeepSIM microscope, is an open and
flexible upright microscope platform optimised for rapid 3D SIM image
stacks deep in large samples previously intractable by SIM.


Microscope AOtools
==================

`Microscope AOtools <https://pypi.org/project/microscope-aotools>`_
builds on top of Microscope support of adaptive optics devices to
perform sensorless adaptive optics correction with a variety of
metrics.


PyME
====

`PyME <https://python-microscopy.org/>`_ is a free and open source
program for microscope image acquisition and data analysis with a
special focus on single molecule localisation microscopy.  PyME has
its own hardware drivers as well as an adapter to use Python
Microscope devices (``PYME.Acquire.Hardware.microscope_adapter``).
