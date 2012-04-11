require 'spec_helper'

module Middleman
  module Features
    require 'lib/target'
  end
end

class HelperTest
  include Middleman::Features::Target::HelperMethods
end

describe Middleman::Features::Target do
  describe Middleman::Features::Target::ClassMethods do
  end

  describe Middleman::Features::Target::HelperMethods do
    before(:each) do
      @base = HelperTest.new
    end

    describe '#build_target_is?' do
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