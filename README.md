# CircleCI Orb for WP Engine Deploys

This is an orb that can be used in your CircleCI workflows. With it you can test WordPress site repos and deploy to WP Engine environments.

## Sample CircleCI Config

This is a sample setup for deploying to a WP Engine site.

`.circleci/config.yml`

```yml
orbs:
    wpengine: ryanshoover/wpengine@volatile

workflows:
    version: 2

    build_test_deploy:
        jobs:
            - wpengine/lint
            - wpengine/codeception

            - wpengine/build_deploy:
                name:         deploy-development
                environment:  development
                requires:
                    - wpengine/lint
                    - wpengine/codeception
                filters:
                    branches:
                        only: development


            - wpengine/build_deploy:
                name:         deploy-staging
                environment:  staging
                requires:
                    - wpengine/lint
                    - wpengine/codeception
                filters:
                    branches:
                        only: staging

            - wpengine/build_deploy:
                name:         deploy-production
                environment:  production
                requires:
                    - wpengine/lint
                    - wpengine/codeception
                filters:
                    branches:
                        only:
                            - master
                            - production

    visual_regression:
        jobs:
            - wpengine/backstop:
                filters:
                    branches:
                        only:
                            - staging
```

Environment Variables

* The WPE Environment variables are required for deployments. These should match your WP Engine site environment names.
* The [Rollbar access token](https://docs.rollbar.com/reference#section-authentication) allows you to notify rollbar about the deploy process
* The Composer Auth variable allows you to install private GitHub repositories with your personal [GitHub token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).

```bash
WPE_PRODUCTION_ENVIRONMENT=mysite
WPE_STAGING_ENVIRONMENT=mysitestaging
WPE_DEVELOPMENT_ENVIRONMENT=mysitedevelop
ROLLBAR_ACCESS_TOKEN=abcdef123456
COMPOSER_AUTH={"github-oauth":{"github.com":"abcdef123456"}}
```
