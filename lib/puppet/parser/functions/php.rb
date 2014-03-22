require 'rubygems'

module Puppet::Parser::Functions

  class Php
    def extension_dir()
     res = `/usr/bin/php -i | /bin/grep extension_dir | /usr/bin/awk {'print $5'}`
      return res.strip()
    end
  end

  newfunction(:php, :type => :rvalue) do |args|
    action = args[0]
    object = Php.new()
    
    case action
      when 'extension_dir'
      return object.extension_dir()
    end
  end
end
