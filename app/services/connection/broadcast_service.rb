module Connection
  class BroadcastService
    class << self
      def perform(data, *subscriblers)
        subscriblers.flatten.map do |subscribler|
          ActionCable.server.broadcast("SUBSCRIBLER::#{subscribler}", data)
        end
      end
    end
  end
end
