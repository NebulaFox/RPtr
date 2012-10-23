# RPtr - Ruby Pointer

In short, it points the binary in `/bin` for ruby to other installed locations of ruby.

This does require ruby version > 1.9 and requires the psych ruby gem for [yaml][yaml],
which comes as standard since ruby 1.9.2.

## Example
I have two versions of Ruby.
One from Mac OS X and the other from MacPorts.

```sh
./rptr.rb where /usr/bin/ruby
./rptr.rb add /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby system
./rptr.rb add /opt/local/bin/ruby1.9 port
```

To then use the MacPorts version
```sh
./rptr.rb use port
```

For  help please use
`./rptr.rb help`

[yaml]: http://www.opinionatedprogrammer.com/2011/04/parsing-yaml-1-1-with-ruby/ (Why am I using Psych instead of yaml)