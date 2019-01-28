# Offender Management Allocation API

[![Maintainability](https://api.codeclimate.com/v1/badges/00cf8469d692073171ce/maintainability)](https://codeclimate.com/github/ministryofjustice/offender-management-allocation-api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/00cf8469d692073171ce/test_coverage)](https://codeclimate.com/github/ministryofjustice/offender-management-allocation-api/test_coverage) [![CircleCI](https://circleci.com/gh/ministryofjustice/offender-management-allocation-api.svg?style=svg)](https://circleci.com/gh/ministryofjustice/offender-management-allocation-api)

## Setup

Install the git pre-commit hook before you start working on this repository so
that we're all using some checks to help us avoid committing unencrypted
secrets. From the root of the repo:

```
ln -s ../../config/git-hooks/pre-commit.sh .git/hooks/pre-commit
```

To test that the pre-commit hook is set up correctly, try removing the `diff`
attribute from a line in a `.gitattributes` file and then committing something -
the hook should prevent you from committing.

### Start the application

```
$ bundle
$ rails s -p 8000
```

### Check application status
Visit `localhost:8000/status`

