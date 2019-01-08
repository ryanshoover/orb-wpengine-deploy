# CircleCI Orb for WP Engine Deploys

This is a CircleCI orb that can be used in your Circle workflows. With it you can test WordPress site repos and deploy to WP Engine environments.

## Sample CircleCI Config

This is a sample setup for deploying to a WP Engine site.

`.circleci/config.yml`

```yml
workflows:
    version: 2

    build_test_deploy:
        jobs:
            - lint
            - codeception

            - build_deploy:
                name:         deploy-development
                environment:  development
                requires:
                    - lint
                    - codeception
                filters:
                    branches:
                        only: development


            - build_deploy:
                name:         deploy-staging
                environment:  staging
                requires:
                    - lint
                    - codeception
                filters:
                    branches:
                        only: staging

            - build_deploy:
                name:         deploy-production
                environment:  production
                requires:
                    - lint
                    - codeception
                filters:
                    branches:
                        only:
                            - master
                            - production

    visual_regression:
        jobs:
            - backstop:
                filters:
                    branches:
                        only:
                            - staging
```

Environment Variables

```bash
WPE_PRODUCTION_ENVIRONMENT=mysite
WPE_STAGING_ENVIRONMENT=mysitestaging
WPE_DEVELOPMENT_ENVIRONMENT=mysitedevelop
ROLLBAR_ACCESS_TOKEN=abcdef123456
```
