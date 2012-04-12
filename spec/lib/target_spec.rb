require 'spec_helper'

module Middleman
  module Features
    require 'lib/target'
  end
end

class HelperMethodTest
  include Middleman::Features::Target::HelperMethods
end

class ClassMethodTest
  include Middleman::Features::Target::ClassMethods
end

###

describe Middleman::Features do
  describe Middleman::Features::Target do
    describe '.registered' do
      pending "Not sure how to test this guy"
    end
  end

  describe Middleman::Features::Target::ClassMethods do
    before(:each) do
      @base = ClassMethodTest.new
    end

    describe '#set_build_targets' do
      it 'should set the build_targets setting to be the passed value' do
        # expect
        @base.stub!(:settings).and_return(mock('settings'))
        @base.settings.should_receive(:build_targets=).once.with({:foo => 'bar'})

        # when
        @base.set_build_targets({:foo => 'bar'})
      end

      it 'should only accept hashes as arguments' do
        lambda {
          @base.set_build_targets('string')
        }.should raise_error(RuntimeError)
      end
    end
  end

  describe Middleman::Features::Target::HelperMethods do
    before(:each) do
      @base = HelperMethodTest.new
    end

    describe '#build_target_is?' do
      before(:each) do
        @base.stub!(:settings).and_return(mock('settings', :build_targets => {}))
      end

      it 'should be true if build target matches passed argument' do
        # given
        @base.stub!(:build_target).and_return(:foo)

        # expect
        @base.build_target_is?(:foo).should be_true
      end

      it 'should be false if build target does not match passed argument' do
        # given
        @base.stub!(:build_target).and_return(:bar)

        # expect
        @base.build_target_is?(:foo).should be_false
      end

      it 'should be true if build_targets defines a target that "includes" this target' do
        # given
        @base.stub!(:build_target).and_return(:android)

        @base.stub!(:settings).and_return(
          mock('settings', :build_targets => {
            "phonegap" => {
              :includes => %w[android ios]
            }
          })
        )

        # expect
        @base.build_target_is?(:phonegap).should be_true
      end

      it 'should be false if build_targets is defined but does "include" target in any definition' do
        # given
        @base.stub!(:build_target).and_return(:winmo6)

        @base.stub!(:settings).and_return(
          mock('settings', :build_targets => {
            "phonegap" => {
              :includes => %w[android ios]
            }
          })
        )

        # expect
        @base.build_target_is?(:phonegap).should be_false
      end
    end

    describe '#default_target?' do
      it 'should be true if the current target is the default target' do
        # given
        @base.stub!(:build_target).and_return(
          Middleman::Features::Target::HelperMethods::DEFAULT_BUILD_TARGET
        )

        # expect
        @base.default_target?.should be_true
      end
      it 'should be false if the current target is not the default target' do
        # given
        @base.stub!(:build_target).and_return(:something)

        # expect
        @base.default_target?.should be_false
      end
    end

    describe '#build_target' do
      before(:each) do
        @base.stub!(:settings).and_return(mock('settings', :build_targets => {}))
      end
      it 'should return the specified build target if one was given' do
        # given
        ENV['MIDDLEMAN_BUILD_TARGET'] = 'something'

        # expect
        @base.build_target.should == :something
      end
      it 'should downcase and symbolize the given build target' do
        # given
        ENV['MIDDLEMAN_BUILD_TARGET'] = 'SoMeThInG'

        # expect
        @base.build_target.should == :something
      end
      it 'should return the default build target if one was given' do
        # given
        ENV['MIDDLEMAN_BUILD_TARGET'] = nil

        # expect
        @base.build_target.should == Middleman::Features::Target::HelperMethods::DEFAULT_BUILD_TARGET
      end
    end

  end
end