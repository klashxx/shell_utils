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

*since* ::

  $ since 20120328
  1304 days 00 hours 11 mins 08 seconds

  $ since 2015/08/08
  76 days 00 hours 11 mins 11 seconds

  $ since yesterday
  1 days 00 hours 00 mins 00 seconds

  $ since 2015-10-12
  11 days 00 hours 11 mins 46 seconds

*bigger_than* ::

  $ bigger_than 150M
        Size => [File                                           ] (Timestamp)
  ===========================================================================
   170.4 MBs => [./assistants/dbca/templates/sampleschema.dfb   ] (2014-07-07)
   304.3 MBs => [./assistants/dbca/templates/Seed_Database.dfb  ] (2014-07-07)
   308.7 MBs => [./bin/oracle                                   ] (2015-10-03)
   311.2 MBs => [./lib/libserver12.a                            ] (2015-10-03)

  $ bigger_than 2k
        Size => [File                                           ] (Timestamp)
  ===========================================================================
       2 KBs => [./.git/logs/refs/heads/master                  ] (2015-10-23)
       2 KBs => [./.git/logs/HEAD                               ] (2015-10-23)
       3 KBs => [./.git/hooks/update.sample                     ] (2015-10-22)
       4 KBs => [./.git/hooks/pre-rebase.sample                 ] (2015-10-22)
