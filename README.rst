WTFIT ?
=======

On a daily basis *tiny* ``shell`` utilities.

lib.sh
------

``shell`` library including:

- ``not_supported``: Environment sanity check.
- ``log``: Simplistic logger function.
- ``error``: logs a critical message.
- ``check``: Test external util ``exit``.
- ``since``: Displays time since a given date.
- ``bigger_than``: ``find`` files thar are *bigger* > ``parameter``.

To load the **library** in the current context use `source 
<https://en.wikipedia.org/wiki/Source_%28command%29>`_  
or *dot* operator ``.``::

  source lib.sh
  . lib.sh

**Examples**

*log* ::
  $ log "Test message"
  [2015-10-22T23:39:27] Test message


