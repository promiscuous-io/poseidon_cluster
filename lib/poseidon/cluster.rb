require 'socket'
require 'thread'

require 'poseidon'
require 'zk'

module Poseidon::Cluster
  MAX_INT32 = 0x7fffffff
  @@sem = Mutex.new
  @@inc = 0

  # @return [Integer] an incremented number
  # @api private
  def self.inc!
    @@sem.synchronize do
      @@inc += 1;

      if @@inc > MAX_INT32
        @@inc = 1
      end

      @@inc
    end
  end

  # @return [String] an globally unique identifier
  # @api private
  def self.guid
    [::Socket.gethostname, ::Process.pid, inc!].join('-')
  end
end

require 'poseidon/consumer_group'
