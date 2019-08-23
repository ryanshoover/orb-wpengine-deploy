# CircleCI Orb for WP Engine Deploys

This is an orb that can be used in your CircleCI workflows. With it you can test WordPress site repos and deploy to WP Engine environments.

## Available Options

### Executors

`base`

A basic PHP 7.2 container with node and browsers included.

`wp-browser`

A custom container that supports codeception testing. The container is based on the [ryanshoover/wp-browser](https://github.com/ryanshoover/docker-wp-browser) image.

`backstop`

A container based on the backstop Docker image.

### Commands

`install`

General setup command. Handles cache, git checkout, composer install, and yarn install.

### Jobs

`lint`

Lint the files to make sure everything follows best practices. `yarn run lint` can be a combination of phpcs, jslint, sass-lint, and more

`codeception`

Run codeception tests for end-to-end testing. Codeception supports unit, wpunit functional, and acceptance testing.

`packageCodeception`

Run codeception tests on plugins and themes. Codeception supports unit, wpunit functional, and acceptance testing.

`backstop`

Run visual regression tests using backstopjs

`build_deploy`

Build and deploy the codebase to a WP Engine environment

## Sample CircleCI Config

See the [sample circleci config file](example_circleci/config.yml) for a copy-paste solution to get you up and running.

## Environment Variables

I suggest you define your environment variables in your Project Settings. See [CircleCI documentation](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project) on the many ways to define environment variables.

* WPE Environment variables are required for deployments. These should match your WP Engine site environment names.
* A [Rollbar access token](https://docs.rollbar.com/reference#section-authentication) allows you to notify rollbar about the deploy process
* A Composer Auth variable allows you to install private GitHub repositories with your personal [GitHub token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).

```bash
WPE_PRODUCTION_ENVIRONMENT=mysite
WPE_STAGING_ENVIRONMENT=mysitestaging
WPE_DEVELOPMENT_ENVIRONMENT=mysitedevelop
ROLLBAR_ACCESS_TOKEN=abcdef123456
COMPOSER_AUTH={"github-oauth":{"github.com":"abcdef123456"}}
```
