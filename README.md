[![Build Status](https://travis-ci.org/xunker/middleman-target.png?branch=master)](https://travis-ci.org/xunker/middleman-target)
[![Code Climate](https://codeclimate.com/github/xunker/middleman-target.png)](https://codeclimate.com/github/xunker/middleman-target)

# Middleman-Target

Middleman-Target is an extension to [MIDDLEMAN] 3.x.x and greater to allow
you to specify a build target and generate the content accordingly.

You can use Middleman-Target in your Middleman project to build multiple
versions of your source from one source tree. This is especially useful for
Phonegap/Cordova, so you can use one source tree to build apps for different
platforms.

NOTE: This version is for [MIDDLEMAN] >= 3.x.x and Ruby >= 1.9.1. For
compatibility with Middleman 2.x.x or Ruby 1.8.7, please see version 0.0.1
of this gem.

# Examples

## Simple

ERB code:

    <p>
      <%# NOTE: target?() is a shorthand alias for build_target_is?() %>
      <% if build_target_is?(:foo) %>
        Foo specific stuff.
      <% elsif target?(:bar) %>
        Bar specific stuff.
      <% else %>
        The build target <%= build_target %> has no special needs.
      <% end %>
    </p>

Output when run with a build target of 'foo':

    Foo specific stuff.

..'bar':

    Bar specific stuff.

..anything else ('baz' in this case):

    The build target baz has no special needs.

## Less simple using build target maps:

If you wanted a particular condition to apply to more than one target you may
do something like:

    if (target?(:anrdroid) || target?(:ios)) { ... }

..but that can get ugly.  Instead we have the concept of "build target maps".
They are declared in the `config.rb`:

    activate :target do |t|
      t.build_targets = {
        "phonegap" => {
          :includes => %w[android ios]
        }
      }
    end

..this means that if my current built target is "android", a query like:

    build_target_is?(:phonegap)

..will be TRUE since "android" is specifed as being 'included' in this
phonegap build target.

NOTE: You cannot "build" the "phonegap" target directly, you would build the
"android" and "ios" targets separately.  This is here so you can specify
conditions that span two or more build targets without having to make
complicated "if" statements.

## Default target

If no target is specified the target of "default" is assumed.

## More Examples

Please see the EXAMPLES directory for more thorough information.

# Building a target

Middleman-target doesn't yet properly connect to the CLI portion of Middleman.
Instead, to specify a build target you currently use and environment variable
named "MIDDLEMAN_BUILD_TARGET".

To build the target of "aardvark" you would run:

    MIDDLEMAN_BUILD_TARGET=aardvark middleman build

## Installing in to Middleman tree

Add the following near the top of your `config.rb`:

    require 'rubygems' # may not be needed depending on ruby ver
    require 'middleman-target'
    activate :target

To specify a build target map, pass a block in to the `activate` method as:

    activate :target do |t|
      t.build_targets = { ... }
    end

Please see /examples for a working usage example.

# TODO:

* repace target.build_targets with something more extensible
* write rdoc
* validate the hash passed in to set_build_targets()
* set build target on the command line as "middleman build TARGET"
* use app.set instead of always reading ENV for build target
* not allowed to use a build target from the command line if that build_target if specified as a first-order entry in set_build_targets()

# Contributing

If there is any thing you'd like to contribute or fix, please:

  * Fork the repo
  * Make your changes
  * Add Cucumber tests for any new functionality
  * Verify all existing tests work properly
  * Make a pull request

The Cucumber features for this project assume the gem is installed, so to make any changes you will need to build and install the gem locally with your changes.

# Changes

0.0.7
  * Tested with middleman 3.3.7, changed post-install warning to reflect this.
  * Fixes https://github.com/xunker/middleman-target/issues/12

0.0.6
  * Removed maximal middleman version requirement. If the version of middleman
  currently installed in greater than the last-tested version, a post-install
  warning is given but the installation will succeed.

0.0.5
  * Changed middleman dependency from ~>3.0.11 to >= 3.0.0 and < 3.2

0.0.4
  * Fixes https://github.com/xunker/middleman-target/issues/3

# Misc

The middleman-target gem is Copyright 2012-2015 Matthew Nielsen, distributed
under the MIT License.

Thanks to jtwalters@github for patches and motivation to add Middleman 3
compatibility.

[MIDDLEMAN]: https://github.com/middleman/middleman/
