Lighttpd Client
===============

This is a small client to protocol http access log through an zmq client.

For this to work, the mod_accesslog as the be enabled and the following line
has to be set:

```
accesslog.filename = "|/export/home/gibheer/project/eventstorm/clients/lighttpd/lighttpd.rb"
```

The log format has to be set to

```
accesslog.format = "%h|%t|%m|%s|%b|%U|%f|%q|%T|%{User-Agent}i|%{Referer}i"
```
