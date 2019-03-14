## Brightness widget

### Installing

You have to add the path of `set_brightness.sh` script to the `/etc/sudoers` 
file as follow:
```
ALL ALL = (root) NOPASSWD: $FULL_PATH_TO_WIDGET/set_brightness.sh
```
This is necessary because setuid bit does nothing on a modern OS

