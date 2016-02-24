Container Farm 
===============
### A simple vagrant setup for exposing your service onto a host

If you have a service packaged as a docker image up and ready to go, then this setup can help you quickly expose the service onto the local host (OS X in my case) on a specified port. This is pretty useful for quick testing and development puposes.

## Simple Redis Server
(This assumes that you already have a working installation of Vagrant)

Creating a Redis server and exposing the port `6379` to your host machine is very simple. 
Say you want the farm to be called `my-redis`

All you have to run at this point is:
```
$> ./createfarm --help
options:
-h, --help                show brief help
-p,                       specify a port to be mapped
-m,                       specify memory of vagrant vm
-n,                       specify name of your farm
-c,                       specify name of your docker image

$> ./createfarm.sh -p 6379 -n my-redis -c redis
$> cd my-redis
$> vagrant up
```

That's it, you should now have a Redis server exposed on port 6379 on your machine. What has happened here is,
- port 6379 is connected to port 6379 on Vagrant VM
- port 6379 on the redis container is connected to the port 6379 on the VM.

2 levels of virualization at a single command.
