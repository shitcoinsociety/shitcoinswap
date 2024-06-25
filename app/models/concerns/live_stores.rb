module LiveStores
  extend ActiveSupport::Concern

  class Store
    attr_accessor :transmitter

    def initialize subject, store_id = nil
      @subject = subject
      @store_id = store_id
    end

    def transmit data
      if Current.transmitter
        Current.transmitter.transmit ({store_id: @store_id}).compact.merge(data)
      else
        LiveStoresChannel.broadcast_to @subject, ({store_id: @store_id}).compact.merge(data)
      end
    end

    def set value
      transmit action: "set", value: value
    end

    def update changes
      transmit action: "update", changes: changes
    end

    def update_by_id_in key, id, changes
      transmit action: "update_by_id_in", key: key, id: id, changes: changes
    end

    def append_to key, value
      transmit action: "append_to", value: value, key: key
    end
  end

  included do
    def livestore store_id = nil
      Store.new self, store_id
    end
  end
end
