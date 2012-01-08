Evenstorm 
=========

Eventstorm is a pluggable event aggregation and storage framework 
in development. Our intention is to build a layer on top of ZMQ defining 
semantics and standard components/interfaces.

Eventstorm will support reporting and analysis. It is not 
a traditional message broker / bus. It does not offer any QOS guarantee nor 
reliability. Its purpose is to aggregate events for later or real-time 
aggregation and consumption.

Event:
------

An event can be any object that can be represented as a BSON Object.

Event examples:

* HTTP-Hit
* SSH-Login
* Business transaction
* SMTP-Transaction
* {CPU,Memory,Disk}-Usage
* ...

Components:
-----------

Eventstorm is currently planned to be divided into tree major component types. 

* EventSource 
  Source for events. Can be a free standing logparser or a buildin / module for
  the event generating software.
  We are planning:
  - Generic event source (lib) for ruby, and C.
  - Postfix
  - Nginx
  - ...

* EventRouter
  A middle man. Not required but sometimes necessary.
  Can be free standing or integrated into EventSink.
  Acts as a EventSink to EventSource.
  Acts as a EventSource to EventSink.

* EventSink
  Events are only generated to end up here. Currently we plan two types:
  - Database storage:
    - mongodb
    - cassandra
  - Realtime Analysis
    - Browserbased graphing

Implementation:
---------------

The implementation does currently NOT exist. We plan to build on ZMQ PUB/SUB 
sockets. We'll use zmq-2.1, once 3.x is stable we'll switch and benefit from 
the new features, like subscription propagnation.

Lost-Events:
------------

There are many reasons an event can be lost. Crashed Database, broken Network, 
bug in software etc.
We will not add any reliability layer on top of ZMQ. An EventSource dos not know 
when or if a message arrives.

Roadmap:
--------

We'll focus on EventSource libraries and the database EventSinks. 
Once this is ready we'll try to build some fancy nice realtime graphs.
With that come the router, as the data should be preserved for later analyses.