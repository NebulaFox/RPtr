# RPtr - Ruby Pointer

In short, it points the binary in `/bin` for ruby to other installed locations of ruby.

## Example
I have two versions of Ruby.
One from Mac OS X and the other from MacPorts.

```sh
./rptr.rb add /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby system
./rptr.rb add /opt/local/bin/ruby1.9 port
```

To then use the MacPorts version
```sh
./rptr.rb use port
```

For  help please use
`./rptr.rb help`
