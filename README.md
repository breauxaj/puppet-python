python
======

Installs python and additional tools. Can deploy basic instances to /var/virtual.

Samples
-------
```
include python
```
```
python::virtual { 'sandbox': user=> 'deploy', group => 'deploy' }
```
```
python::modules { 'urllib': }
```

License
-------
GPL3

Contact
-------
breauxaj AT gmail DOT com
