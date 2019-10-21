# dev notes

 running notes ....

## hover packaging

On mac the linux packing is a bit broken.

See: https://github.com/go-flutter-desktop/go-flutter/issues/287#issuecomment-544161253

Here is a way to help you debug whats wrong on linux at least.

From a mac you can connect to the linux shell inside docker and do this:

This works:
````

$ cd dockertemp/T/hover-build-draggable_borderless-linux-snap875683786
$ docker build . -t hover-snap-manual 
$  docker run -w /app -v $(pwd):/app hover-snap-manual snapcraft
# produced draggableborderless_1.0.0+1_amd64.snap
I also deleted the lib dir (the one that produced your error) and it worked.

````

I also deleted the lib dir (the one that produced your error) and it worked.

````


$ cd dockertemp/T/hover-build-draggable_borderless-linux-snap875683786
$ rm -rf parts/app/install/lib/x86_64-linux-gnu/lib
$ # docker build . -t hover-snap-manual  # the same as the one above, not going to run it twice 
$ docker run -w /app -v $(pwd):/app hover-snap-manual snapcraft 
# produced draggableborderless_1.0.0+1_amd64.snap

```