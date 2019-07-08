workflow "Docs/Tests" {
  on = "push"
  resolves = [
    "Runs the linters and tests (Rails 4)",
    "Runs the linters and tests (Rails 5)",
    "Runs the linters and tests (Rails 6)"
  ]
}

action "Builds the Docker image" {
  uses = "actions/docker/cli@master"
  args = "build -f Dockerfile -t active_record-pgcrypto/ci:$GITHUB_SHA ."
}

action "Runs the linters and tests (Rails 4)" {
  uses = "actions/docker/cli@master"
  needs = ["Builds the Docker image"]
  args = "run -e RAILS_VERSION='~> 4' active_record-pgcrypto/ci:$GITHUB_SHA"
}

action "Runs the linters and tests (Rails 5)" {
  uses = "actions/docker/cli@master"
  needs = ["Builds the Docker image"]
  args = "run -e RAILS_VERSION='~> 5' active_record-pgcrypto/ci:$GITHUB_SHA"
}

action "Runs the linters and tests (Rails 6)" {
  uses = "actions/docker/cli@master"
  needs = ["Builds the Docker image"]
  args = "run -e RAILS_VERSION='~> 6.0.0.rc1' active_record-pgcrypto/ci:$GITHUB_SHA"
}
