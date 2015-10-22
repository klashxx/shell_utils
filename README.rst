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
- ``bigger_than``: ``find`` files *bigger* than ``parameter``.
- ``older_than``: ``find`` files *older* than other archive or given time.

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

*bigger_than* ::

  $ older_than 300 mins
  -rw-rw-r--. 1 klashxx klashxx 23 2015-10-22 18:01:30 ./.git/HEAD
  -rwxrwxr-x. 1 klashxx klashxx 398 2015-10-22 18:01:23 ./.git/hooks/pre-applypatch.sample
  -rwxrwxr-x. 1 klashxx klashxx 1348 2015-10-22 18:01:23 ./.git/hooks/pre-push.sample
  -rwxrwxr-x. 1 klashxx klashxx 1239 2015-10-22 18:01:23 ./.git/hooks/prepare-commit-msg.sample


  $ ls -l
  total 24
  -rwxrwxr-x. 1 klashxx klashxx  492 oct 22 18:01 date_validator.py
  -rwxrwxr-x. 1 klashxx klashxx  687 oct 22 18:01 diffdate.pl
  -rwxrwxr-x. 1 klashxx klashxx 2143 oct 23 00:36 lib.sh
  -rwxrwxr-x. 1 klashxx klashxx 1367 oct 22 18:01 menu.sh
  -rw-rw-r--. 1 klashxx klashxx 2141 oct 23 00:35 README.rst
  -rwxrwxr-x. 1 klashxx klashxx  217 oct 22 18:01 tree.sh
  $ older_than menu.sh 
  -rwxrwxr-x. 1 klashxx klashxx 492 2015-10-22 18:01:30 ./date_validator.py
  -rwxrwxr-x. 1 klashxx klashxx 217 2015-10-22 18:01:30 ./tree.sh
  -rwxrwxr-x. 1 klashxx klashxx 687 2015-10-22 18:01:30 ./diffdate.pl

  $ older_than 7000 days
  -rw-r--r--. 1 oracle oinstall 1472 1995-08-04 09:12:00 ./slax/mesg/pxus.msg
  -rw-r--r--. 1 oracle oinstall 5895 1996-05-29 21:25:00 ./network/mesg/nmpus.msg
  -rw-r--r--. 1 oracle oinstall 12464 1996-05-29 21:25:00 ./network/mesg/nmrus.msg
  -rw-r--r--. 1 oracle oinstall 4658 1996-05-29 21:26:00 ./network/mesg/snlus.msg

