# encoding: utf-8
#
# Licensed to the Software Freedom Conservancy (SFC) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The SFC licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require_relative '../spec_helper'

module Selenium
  module WebDriver
    module Chrome
      describe Options, only: {browser: :chrome} do
        it 'passes emulated device correctly' do
          subject.add_emulation(device_name: 'Nexus 5')

          create_driver!(options: subject) do
            ua = driver.execute_script 'return window.navigator.userAgent'
            expect(ua).to include('Nexus 5')
          end
        end

        it 'passes emulated user agent correctly' do
          subject.add_emulation(user_agent: 'foo;bar')

          create_driver!(options: subject) do
            ua = driver.execute_script 'return window.navigator.userAgent'
            expect(ua).to eq('foo;bar')
          end
        end

        it 'passes args correctly' do
          subject.add_argument('--user-agent=foo;bar')

          create_driver!(options: subject) do
            ua = driver.execute_script 'return window.navigator.userAgent'
            expect(ua).to eq('foo;bar')
          end
        end
      end
    end # Chrome
  end # WebDriver
end # Selenium
