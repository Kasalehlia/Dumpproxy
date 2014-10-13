Dumpproxy
=========

A simple proxy writing requested files to the disk.
This script uses CoffeeScript on Node.JS.
It takes 3 parameters:
* the base URL of the site to be requested
* the path where the files should be written to
* the port on which to listen

## Examples ##
```
coffee main.coffee http://sci.esa.int/ /tmp 8080
```
This listens on port 8080 and relays every requests to `sci.esa.int`, writing the files
both to the browser and to `/tmp`. Missing folders are created automatically.

