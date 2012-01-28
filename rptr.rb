#!/usr/bin/env ruby1.9

# rptr points to installed versions
# rptr add <ruby dir> <alias>

# open or create usr space

require 'yaml'

$home = ENV[ 'HOME' ]
$local = $home + '/.rptr'
$no_local = false

$help_commands = {
    add: "rptr add <other ruby bin> <alias>",
    where: "rptr where <standard ruby bin>",
    use: "rptr use <alias>",
    list: "rptr list",
    implode: "rptr implode",
    help: "rptr help"
}


begin
    File.open( $local, "r" ) do |f|
        $data = YAML.load( f.read )
    end
rescue
    $data = { rubies: {}, where: "" }
end

case ARGV[0]
    when "add"
        if ARGV.length != 3
            puts $help[ :add ]
            raise "incorrect usage of add"
        end
        
        path = ARGV[1]
        
        if File.file?( path )
            $data[ :rubies ][ ARGV[2] ] = path
        else
            raise "ruby:#{path} does not exist or is not a file"
        end
        
    when "where"
        if ARGV.length != 2
            puts $help[ :where ]
            raise "incorrect usage of where"
        end
        
        where = ARGV[1]
        
        if File.file?( where )
            $data[ :where ] = where
        else
            raise "ruby:#{where} does not exist or is not a file"
        end
    
    when "use"
        if ARGV.length != 2
            puts $help[ :use ]
            raise "Incorrect usage of use"
        end
        
        where = $data[ :where ]
        path = $data[ :rubies ][ ARGV[1] ]
        commands = %w{ erb gem irb rake rdoc ri ruby testrb }
        
        if where == ""
            puts "call: rptr where <ruby bin dur>"
            raise "do not know where ruby is installed"
        end
        
        begin 
            commands.each do | value |
                regex = /ruby(?!\/)/
                dest = where.sub( regex, value )
                source = path.sub( regex, value )
                File.delete( dest )
                File.symlink( source, dest )
                #puts "delete:#{dest}"
                #puts "symlink from:#{source} to:#{dest}"
            end
        rescue
            raise "you need to be root"
        end
    when "list"
        where = $data[:where]
        if where == ""
            puts "where:<ruby bin unknown>"
        else
            puts "where:#{$data[:where]}"
        end
        
        puts "rubies:"
        $data[:rubies].each do | key, value |
            puts "  #{key}:#{value}"
        end
    when "implode"
        File.delete( $local )
        $no_local = true
    when "help"
        $help.each_value do | value |
            puts value
        end
end

if $no_local == false
    File.open( $local, 'w' ) do | f |
        f.write YAML.dump( $data )
    end
end