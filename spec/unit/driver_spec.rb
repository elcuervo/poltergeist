require 'spec_helper'

module Capybara::Poltergeist
  describe Driver do
    context 'with no options' do
      subject { Driver.new(nil) }

      it 'should not log' do
        subject.logger.should == nil
      end

      it 'has no inspector' do
        subject.inspector.should be_nil
      end
    end

    context 'with a :logger option' do
      subject { Driver.new(nil, :logger => :my_custom_logger) }

      it 'should log to the logger given' do
        subject.logger.should == :my_custom_logger
      end
    end

    context 'with a :debug => true option' do
      subject { Driver.new(nil, :debug => true) }

      it 'should log to STDERR' do
        subject.logger.should == STDERR
      end
    end

    context 'with an :inspector option' do
      subject { Driver.new(nil, :inspector => 'foo') }

      it 'has an inspector' do
        subject.inspector.should_not be_nil
        subject.inspector.should be_a(Inspector)
        subject.inspector.browser.should == 'foo'
      end
    end

    context 'with a :timeout option' do
      subject { Driver.new(nil, :timeout => 3) }

      it 'starts the server with the provided timeout' do
        server = stub
        Server.should_receive(:new).with(3).and_return(server)
        subject.server.should == server
      end
    end
  end
end
