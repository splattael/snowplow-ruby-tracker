# Copyright (c) 2013 Snowplow Analytics Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.

# Author::    Alex Dean (mailto:snowplow-user@googlegroups.com)
# Copyright:: Copyright (c) 2013 Snowplow Analytics Ltd
# License::   Apache License Version 2.0

require 'contracts'
include Contracts

module Snowplow

  module Performs

    include Protocol

    # Defines the valid Event Symbols
    class EventSymbol

      @@valid_events = Set::[](:se, :ue)

      def self.valid?(val)
        val.is_a? Symbol &&
          @@valid_events.include?(val)
      end
    end

    # Converts this Verb into a Hash representing its
    # event type, ready for adding to the payload.
    # Follows the Snowplow Tracker Protocol:
    #
    # https://github.com/snowplow/snowplow/wiki/snowplow-tracker-protocol
    #
    # Parameters:
    # +ev_symbol+:: whether the Verb is referring to performing
    #               a structured or unstructured event.
    #
    # Returns a VerbHash 
    EventSymbol => VerbHash
    def as_hash(ev_symbol)
      to_protocol([ 'e', ev_symbol.to_s, :raw ])
    end
    module_function :as_hash

    # Subject performs a custom event. Could be either:
    # 1. A Google Analytics-style custom structured event, or:
    # 2. A MixPanel- or KISSmetrics-style custom unstructured event
    #
    # +event+:: the custom structured or unstructured event
    # +context+:: the optional Context in which this event
    #             takes place. Overrides any pinned Context
    #
    # Returns ??
    Contract Or[StructEvent, UnstructEvent], OptionContext => nil # TODO: fix return
    def performs(event,
                 context=nil)

      # Switch based on type of event
      if event.is_a? StructEvent
        performs_struct_event(event, context)
      elsif event.is_a? UnstructEvent
        performs_unstruct_event(event, context)
      else # Should never happen thanks to Contracts
        raise Snowplow::Exceptions::ContractFailure.new
      end

    end
    module_function :performs

    private

    # Subject performs a Google Analytics-style custom structured event.
    # Procedure is private so public API can stick to using the cleaner
    # performs() procedure
    #
    # +event+:: the custom structured event
    # +context+:: the optional Context in which this event
    #             takes place. Overrides any pinned Context
    #
    # Returns ??
    Contract StructEvent, OptionContext => nil # TODO: fix return
    def performs_struct_event(event,
                              context=nil)

      nil # TODO: fix return
    end
    module_function :performs_struct_event

    # Subject performs a MixPanel- or KISSmetrics-style custom unstructured event.
    # Procedure is private so public API can stick to using the cleaner
    # performs() procedure
    #
    # +event+:: the custom unstructured event
    # +context+:: the optional Context in which this event
    #             takes place. Overrides any pinned Context
    #
    # Returns ??
    Contract UnstructEvent, OptionContext => nil # TODO: fix return
    def performs_unstruct_event(event,
                                context=nil)

      nil # TODO: fix return
    end
    module_function :performs_unstruct_event

  end
end
