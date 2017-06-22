require 'rack/deflater'

module Rack
  class Deflater
    class GzipStream
      def each(&block)
        @writer = block
        gzip  =::Zlib::GzipWriter.new(self)
        gzip.mtime = @mtime
        @body.each { |part|
          gzip.write(part)
          gzip.flush
        }
      ensure
        @body.close if @body.respond_to?(:close)
        gzip.close if gzip && !gzip.closed?
        @writer = nil
      end
    end
  end
end
