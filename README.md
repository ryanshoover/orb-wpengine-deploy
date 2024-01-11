# CircleCI Orb for WP Engine Deploys

This is an orb that can be used in your CircleCI workflows. You can use it to test WordPress site repos and deploy to WP Engine environments.

## Available Options

### Jobs

#### `wpengine/build`

Build the files. Runs `composer install`, `yarn install`, and `yarn build` if a build job is defined. This is the base job that creates the core files used by all other jobs. It's a required step 1.

#### `wpengine/lint`

Lint the files to make sure everything follows best practices. Runs both `composer lint` and `yarn lint` if they're defined.

#### `wpengine/codeception`

Run codeception tests for end-to-end testing. Codeception supports unit, wpunit functional, and acceptance testing. Please note that the job needs two parameters defined for plugins and themes

| Parameter | Description |
|-----------|-------------|
| `package_type` | One of `plugin`, `theme`, or `project` |
| `package_name` | The directory name of the plugin or theme. Where should it be installed.  |

#### `wpengine/backstop`

Run visual regression tests using backstopjs. Takes a single required parameter

| Parameter | Description |
|-----------|-------------|
| `config` | Path to the backstopjs config file |

#### `wpengine/deploy_site`

Deploys a site to a WP Engine install. The deploy process removes dev dependencies and any internal git settings.

| Parameter | Description |
|-----------|-------------|
| `environment` | One of `production`, `staging`, `development`, or `SpecificInstallName` |

### Executors

#### `wpengine/php`

A basic PHP 7.4 container with node included.

### Commands

#### `wpengine/gitignoreswap`

Swaps the `.gitignore` file for a plugin, theme, or project to a production-friendly gitignore that excludes source and test files.

| Parameter | Description |
|-----------|-------------|
| `gitignore_type` | One of `site` or `package`. |

## Sample CircleCI Config

See the [sample circleci config files](src/examples/) for a copy-paste solution to get you up and running.

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
