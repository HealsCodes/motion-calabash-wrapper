# Copyright (c) 2014, René Köcher <shirk@bitspin.org>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
# rake helpers to get around a few rough edges of motion calabash

require 'rake/task_arguments'
require 'motion-calabash'

namespace :features do
  desc 'Execute calabash:run on XCode 6.1 / inside RubyMine'
  task :run, [:target] do |t, args|

    if ENV['CUCUMBER_FORMAT']
      cc_args = "--format #{ENV['CUCUMBER_FORMAT']} #{ENV['args']}"
    else
      cc_args = ENV['args']
    end

    # for whatever reason motion-calabash requires the device target to be a real ARGV element
    # instead of the more portable task argument - work around this..
    target = ARGV.select { |v| v =~ /device|(?:iPhone (?:4s?|5s?|6|6 Plus)|iPad (?:2|Air|Retina)) \(\d.\d Simulator\)/ }.last
    
    if target.nil?
      target ||= args[:target] || ENV['DEVICE_TARGET'] || nil  
      if target.nil?
        App.warn( 'No device / simulator specified defaulting to \'iPhone 6 (8.1 Simulator)\'' )
        target = 'iPhone 6 (8.1 Simulator)'
      end
      ARGV.push( target )
    end

    ENV['args'] = cc_args
    ENV['DEVICE_TARGET'] = target

    Rake::Task['calabash:run'].execute
  end
end
