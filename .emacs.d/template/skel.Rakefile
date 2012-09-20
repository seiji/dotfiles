require 'rubygems'
require 'rake'

CC = 'gcc'
CFLAGS = '-Wall'
LDFLAGS = ''                    # i.g. '-lz'
LIBS = ''
INCLUDES =''                    # i.g. '-Ilib/minizip'
EXECUTABLE='idb'

task :default => "#{EXECUTABLE}"
desc 'Compile "#{EXECUTABLE}"'
file "#{EXECUTABLE}" => ['idb.c', 'MobileDevice.h'] do |t|
  sh %Q["#{CC}" "#{CFLAGS}" "#{LDFLAGS}" -o "#{t.name}" \
"#{LIBS}" "#{INCLUDES}" \
-framework CoreFoundation \
-framework MobileDevice \
-F/System/Library/PrivateFrameworks \
"#{t.prerequisites.join('" "')}"]
end

desc "Install #{EXECUTABLE} on the system"
task :install => "#{EXECUTABLE}" do |t|
  sh %Q[/bin/cp -f "#{t.prerequisites.join('" "')}" /usr/local/bin/]
end

desc 'Clean'
task :clean do |t|
  sh "rm -f #{EXECUTABLE}"
end
