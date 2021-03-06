# Copyright (c) 2013-2014 Snowplow Analytics Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.

# Author:: Alex Dean, Fred Blundun (mailto:support@snowplowanalytics.com)
# Copyright:: Copyright (c) 2013-2014 Snowplow Analytics Ltd
# License:: Apache License Version 2.0

#require 'spec_helper'

describe SnowplowTracker::Payload, 'context' do

  before(:each) do
    @pb = SnowplowTracker::Payload.new
  end

  it 'initializes with an empty context hash' do
    @pb.context.should eq({})
  end

  it 'adds single key-value pairs to the context' do
    @pb.add('key1', 'value1')
    @pb.add('key2', 'value2')
    @pb.context.should eq({'key1' => 'value1', 'key2' => 'value2'})
  end

  it 'adds a dictionary of key-value pairs to the context' do
    @pb.add_dict({
      'p' => 'mob',
      'tna' => 'cf',
      'aid' => 'cd767ae'
      })
    @pb.context.should eq({
      'p' => 'mob',
      'tna' => 'cf',
      'aid' => 'cd767ae'      
      })
  end

  it 'turns a JSON into a string and adds it to the context' do
    @pb.add_json({'a' => {'b' => [23, 54]}}, false, 'cx', 'co')
    @pb.context.should eq({
      'co' => "{\"a\":{\"b\":[23,54]}}" 
      })
  end

  it 'base64-encodes a JSON string' do
    @pb.add_json({'a' => {'b' => [23, 54]}}, true, 'cx', 'co')
    @pb.context.should eq({
      'cx' => "eyJhIjp7ImIiOlsyMyw1NF19fQ=="
      })
  end

end