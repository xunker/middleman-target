Feature: Target

  Scenario: build target name
    Given build target is "foo"
    And the Server is running at "build_target"
    When I go to "/build_target.html"
    Then I should see "current build target: foo"

  Scenario: build target map
    Given build targets are set to "test" values
    And the Server is running at "build_target_map"
    When I go to "/build_targets.html"
    Then I should see "blah"

  Scenario: build target is "phonegap" which includes "ios"
    Given build targets are set to "phonegap" values
    And build target is "ios"
    And the Server is running at "basic-app"
    When I go to "/build_target_includes.html"
    Then I should see "Specified target is included in phonegap target."

  Scenario: build target is "phonegap" which does not include "windows_phone"
    Given build targets are set to "phonegap" values
    And build target is "windows_phone"
    And the Server is running at "basic-app"
    When I go to "/build_target_includes.html"
    Then I should see "Specified target is not in phonegap target."

  Scenario: no target or using default build target
    Given the Server is running at "basic-app"
    When I go to "/default_target.html"
    Then I should see "Using the default build target, or no target specified."

  Scenario: target specified, not using default build target
    Given the Server is running at "basic-app"
    When I go to "/default_target.html"
    Then I should see "A build target has been specified that is not the default."
