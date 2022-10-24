#!/usr/bin/env python3

## Copyright (C) 2020 David Miguel Susano Pinto <david.pinto@bioch.ox.ac.uk>
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

project = "Microscope"

master_doc = "doc/index"
language = "en"
nitpicky = True

templates_path = ["_templates"]

extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.intersphinx",
    "sphinx.ext.napoleon",
    "sphinx.ext.todo",
    "sphinx.ext.viewcode",
]

# sphinx.ext.autodoc
autodoc_mock_imports = [
    "ctypes",
    "microscope._wrappers",
    "microscope.cameras._SDK3",
    "microscope.cameras._SDK3Cam",
    "ximea",
]

# sphinx.ext.napoleon
napoleon_google_docstring = True
napoleon_include_private_with_doc = False
napoleon_include_special_with_doc = False

# sphinx.ext.todo
todo_include_todos = False

html_theme = "microscope"
html_theme_path = ["_themes"]

html_static_path = [
    "_static",
    "node_modules/bootstrap-icons/icons/bounding-box.svg",
    "node_modules/bootstrap-icons/icons/box-seam.svg",
    "node_modules/bootstrap-icons/icons/card-list.svg",
    "node_modules/bootstrap-icons/icons/code-slash.svg",
    "node_modules/bootstrap-icons/icons/file-text.svg",
    "node_modules/bootstrap-icons/icons/gear.svg",
    "node_modules/bootstrap-icons/icons/people.svg",
    "node_modules/bootstrap-icons/icons/person-plus.svg",
    "node_modules/bootstrap/dist/css/bootstrap.min.css",
    "node_modules/bootstrap/dist/js/bootstrap.bundle.min.js",
    "node_modules/jquery/dist/jquery.slim.min.js",
]
html_additional_pages = {
    "index": "index.html",
}

html_title = "Python Microscope"
html_show_copyright = True
html_show_sphinx = False
html_copy_source = False
html_show_sourcelink = False

html_add_permalinks = ""

html_logo = "_static/microscope-logo.svg"
html_favicon = "_static/microscope-logo.svg"

# We only document microscope packages so ignore the microscope root
# level when preparing the index, i.e., "microscope.abc" and
# microscope.gui" will appear under A, for abc, and G, for gui,
# instead of under M, for microscope.
mod_index_common_prefix = ["microscope."]

# Mapping passed into Jinja's contex for all pages.
html_context = {
    "description": (
        "Microscope is a Python package for the control of automated"
        " microscopes. It is easy to use and especially well suited for"
        " complex microscopes with hard timing requirements."
    ),
    # The content of the cards at the home page.
    "home_cards": [
        (
            "Easy To Use",
            (
                "Built on top of Python, Microscope has a simple"
                " interface to even the most complicated devices."
            ),
        ),
        (
            "Common Interface",
            (
                "Microscope provides a common interface to all devices"
                " of same type.  Replace any devices, free from vendor"
                " lock-in."
            ),
        ),
        (
            "Python Scientific Stack",
            (
                "Native access to all of Python scientific computing"
                " tools, such as Numpy, SciPy, Tensorflow, and PyTorch."
            ),
        ),
        (
            "Distributed Devices",
            (
                "Builtin in support for remote control enables"
                " distribution of devices over any number of computers."
            ),
        ),
        (
            "Performant",
            (
                "Microscope was designed from the start to support"
                " hardware triggers, it provides speed of light"
                " performance."
            ),
        ),
        (
            "Free and Open Source",
            (
                "Distributed under the GNU GPL, Microscope is developed"
                " and maintained publicly on GitHub."
            ),
        ),
    ],
    # FIXME: much of this is duplicated from the master_doc but I
    # don't know how to get to it from the template.  This is used by
    # the "doc-nav" template which is included in all doc/ pages.
    "doc_structure": [
        ("getting-started.html", "Getting Started", "_static/gear.svg", [],),
        ("install.html", "Installation", "_static/box-seam.svg", [],),
        ("examples/index.html", "Examples", "_static/file-text.svg", [],),
        (
            "architecture/index.html",
            "Architecture",
            "_static/bounding-box.svg",
            [
                ("architecture/abc.html", "ABC"),
                ("architecture/supported-devices.html", "Supported Devices"),
                ("architecture/device-server.html", "Device Server"),
#                ("doc/architecture/triggers", "Hardware Triggers"),
                ("architecture/gui.html", "GUI"),
            ],
        ),
        ("api/index.html", "Reference API", "_static/code-slash.svg", [],),
        ("news.html", "Release Notes", "_static/card-list.svg", [],),
        (
            "get-involved/index.html",
            "Get Involved",
            "_static/person-plus.svg",
            [
                ("get-involved/dev-install.html", "Development Installation"),
                ("get-involved/hacking.html", "Contributing"),
                ("get-involved/new-device.html", "New Device"),
            ],
        ),
        ("authors.html", "Authors", "_static/people.svg", [],),
    ],
    "footer_links": {
        "PROJECT": [
            ("/about.html", "About Us"),
            ("/cite.html", "Cite Us"),
            ("https://github.com/python-microscope/microscope", "Code"),
            ("/doc/news.html", "NEWS"),
        ],
        "SUPPORT": [
            ("/doc/architecture/supported-devices.html", "Supported Devices"),
            ("/doc", "Documentation"),
            ("/doc/install.html", "Install"),
            (
                # Link to "issues" and not "issues/new" because if the
                # user is not logged in on github or does not have a
                # github account, "issues/new" redirects to the sign
                # in page.
                "https://github.com/python-microscope/microscope/issues",
                "Report Issue",
            ),
        ],
        "COMMUNITY": [
            ("https://forum.image.sc/", "Forum"),
            ("/related-projects.html", "Related Projects"),
        ],
    },
}

rst_prolog = """
.. _repo-browse: https://github.com/python-microscope/microscope
.. _repo-vcs: https://github.com/python-microscope/microscope.git
.. _gpl-licence: https://www.gnu.org/licenses/gpl-3.0.html
.. _cockpit-link: https://github.com/MicronOxford/cockpit/
"""

intersphinx_mapping = {
    "numpy": ("https://numpy.org/doc/stable/", None),
    "pyro4": ("https://pyro4.readthedocs.io/en/stable/", None),
    "pyserial": ("https://pythonhosted.org/pyserial/", None),
    "python": ("https://docs.python.org/3/", None),
}
