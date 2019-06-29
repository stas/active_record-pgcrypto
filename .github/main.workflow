workflow "Docs/Tests" {
  on = "push"
  resolves = [
    "Builds the Docker image",
    "Runs the linters and tests"
  ]
}

action "Builds the Docker image" {
  uses = "actions/docker/cli@master"
  args = "build -f Dockerfile -t active_record-pgcrypto/ci:$GITHUB_SHA ."
}

action "Runs the linters and tests" {
  uses = "actions/docker/cli@master"
  needs = ["Builds the Docker image"]
  args = "run active_record-pgcrypto/ci:$GITHUB_SHA"
}
