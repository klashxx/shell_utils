WTFIT ?
=======

On a daily basis *tiny* ``shell`` utilities.

lib.sh
------

``shell`` library including:

- ``supported``: Environment sanity check.
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

*supported* ::

  $ if ! supported 2>/dev/null;then echo "Not supported env"; fi
  Not supported env

  $ supported 
  [2015-10-23T00:01:01] critical: Darwin NOT supported.


*log* ::

  $ log "Test message"
  [2015-10-22T23:39:27] Test message


