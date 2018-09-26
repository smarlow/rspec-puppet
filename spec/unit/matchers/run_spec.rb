require 'spec_helper_unit'

describe RSpec::Puppet::FunctionMatchers::Run do
  subject(:matcher) { described_class.new }

  let(:wrapper) { test_double(RSpec::Puppet::FunctionExampleGroup::V4FunctionWrapper) }

  describe '#matches?' do
    context 'when the function takes no arguments and has no expected return value' do
      context 'and returns nothing' do
        it 'returns true' do
          allow(wrapper).to receive(:execute).with(no_args).once
          expect(matcher.matches?(wrapper)).to be_truthy
        end
      end

      context 'and raises an exception' do
        it 'returns false' do
          allow(wrapper).to receive(:execute).with(no_args).and_raise(StandardError, 'Forced Error').once
          expect(matcher.matches?(wrapper)).to be_falsey
        end
      end
    end
  end

  describe '#with_params' do

  end

  describe '#with_lambda' do
    context 'when a lambda is passed to the matcher' do
      let(:block) { proc { |r| r + 2 } }

      before do
      end

      after do
      end

      it 'passes the lambda when executing the function' do
        matcher.with_lambda { |r| r + 2 }
        matcher.matches?(wrapper)
      end
    end
  end
end
