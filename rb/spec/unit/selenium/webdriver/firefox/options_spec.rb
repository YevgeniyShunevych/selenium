# frozen_string_literal: true

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

require File.expand_path('../spec_helper', __dir__)

module Selenium
  module WebDriver
    module Firefox
      describe Options do
        subject(:options) { described_class.new }

        describe '#initialize' do
          it 'sets passed args' do
            opt = Options.new(args: %w[foo bar])
            expect(opt.args.to_a).to eq(%w[foo bar])
          end

          it 'sets passed prefs' do
            opt = Options.new(prefs: {foo: 'bar'})
            expect(opt.prefs[:foo]).to eq('bar')
          end

          it 'sets passed binary value' do
            opt = Options.new(binary: '/foo/bar')
            expect(opt.binary).to eq('/foo/bar')
          end

          it 'sets passed new profile' do
            profile = Profile.new
            opt = Options.new(profile: profile)
            expect(opt.profile).to eq(profile)
          end

          it 'sets passed existing profile' do
            profile = Profile.new
            expect(Profile).to receive(:from_name).with('foo').and_return(profile)
            opt = Options.new(profile: 'foo')
            expect(opt.profile).to eq(profile)
          end

          it 'sets passed log level' do
            opt = Options.new(log_level: 'debug')
            expect(opt.log_level).to eq('debug')
          end

          it 'sets passed options' do
            opt = Options.new(options: {foo: 'bar'})
            expect(opt.options[:foo]).to eq('bar')
          end
        end

        describe '#binary=' do
          it 'sets the binary path' do
            options.binary = '/foo/bar'
            expect(options.binary).to eq('/foo/bar')
          end
        end

        describe '#log_level=' do
          it 'sets the log level' do
            options.log_level = :debug
            expect(options.log_level).to eq(:debug)
          end
        end

        describe '#profile=' do
          it 'sets a new profile' do
            profile = Profile.new
            options.profile = profile
            expect(options.profile).to eq(profile)
          end

          it 'sets an existing profile' do
            profile = Profile.new
            expect(Profile).to receive(:from_name).with('foo').and_return(profile)
            options.profile = 'foo'
            expect(options.profile).to eq(profile)
          end
        end

        describe '#headless!' do
          it 'adds the -headless command-line flag' do
            options.headless!
            expect(options.as_json['moz:firefoxOptions']['args']).to include('-headless')
          end
        end

        describe '#add_argument' do
          it 'adds a command-line argument' do
            options.add_argument('foo')
            expect(options.args.to_a).to eq(['foo'])
          end
        end

        describe '#add_option' do
          it 'adds an option' do
            options.add_option(:foo, 'bar')
            expect(options.options[:foo]).to eq('bar')
          end
        end

        describe '#add_preference' do
          it 'adds a preference' do
            options.add_preference(:foo, 'bar')
            expect(options.prefs[:foo]).to eq('bar')
          end
        end

        describe '#as_json' do
          it 'converts to a json hash' do
            profile = Profile.new
            expect(profile).to receive(:encoded).and_return('foo')

            options = Options.new(args: ['foo'],
                                  binary: '/foo/bar',
                                  prefs: {a: 1},
                                  options: {foo: :bar},
                                  profile: profile,
                                  log_level: :debug)

            json = options.as_json['moz:firefoxOptions']
            expect(json).to eq('args' => ['foo'],
                               'binary' => '/foo/bar',
                               'prefs' => {"a" => 1},
                               'profile' => 'foo',
                               'log' => {'level' => 'debug'},
                               'foo' => 'bar')
          end
        end
      end # Options
    end # Chrome
  end # WebDriver
end # Selenium
