# Middleman-Target

Middleman-Target is an extension to [MIDDLEMAN] 2.0.x to allow you to specify a build target and generate the content accordingly.

You can use Middleman-Target in your Middleman project to build multiple versions of your source from one source tree.

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

If you wanted a particular condition to apply to more than one target you may do something like:

    if (target?(:anrdroid) || target?(:ios)) { ... }

..but that can get ugly.  Instead we have the concept of "build target maps".  They are declared in the config.rb:

    set_build_targets({
      "phonegap" => {
        :includes => %w[android ios]
      }
    })

..this means that if my current built target is "android", a query like:

    build_target_is?(:phonegap)

..will be TRUE since "android" is specifed as being 'included' in this phonegap build target.

NOTE: You cannot "build" the "phonegap" target directly, you would build the "android" and "ios" targets separately.  This is here so you can specify conditions that span two or more build targets without having to make complicated "if" statements.

## Default target

If no target is specified the target of "default" is assumed.

## More Examples

Please see the EXAMPLES directory for more thorough information.

# Building a target

Middleman-target doesn't yet properly connect to the CLI portion of Middleman.  Instead, to specify a build target you currently use and environment variable named "MIDDLEMAN_BUILD_TARGET".

To build the target of "aardvark" you would run:

    MIDDLEMAN_BUILD_TARGET=aardvark middleman build

# TODO:

* set build target on the command line as "middleman build <target>"
* use app.set instead of always reading ENV for build target
* not allowed to use a build target from the command line if that build_target if specified as a first-order entry in set_build_targets()

# REQUIREMENTS AND INSTALLATION

Middleman-Target was developed against [MIDDLEMAN] 2.0.15. Compatibility with other versions is not guaranteed.  When Middleman 3.0 is released this will likely not work with it.

## Gem Version Hell

Because gem authors don't specify minimal and maximal version of dependencies, installing Middleman 2.0.15 can put you in dependency version hell.  To rememdy this, install gems in this order:

    gem install multi_json -v="1.0.3"
    gem install execjs -v="1.2.7"
    gem install middleman -v="2.0.15"
    gem install middleman-target

[MIDDLEMAN]: https://github.com/middleman/middleman/blob/master/LICENSE