workflow "New workflow" {
  on = "push"
  resolves = ["Build", "Lint", "Test", "E2E"]
}

action "Install" {
  uses = "actions/npm@master"
  args = "install"
}

action "Build" {
  needs = "Install"
  uses = "actions/npm@master"
  args = ["run", "build"]
}

action "Lint" {
  needs = "Install"
  uses = "actions/npm@master"
  args = ["run", "lint"]
}

action "Test" {
  needs = "Build"
  uses = "./.github/node-chrome"
  runs = "sh -c"
  args = ["npm test -- --configuration=ci"]
}

action "E2E" {
  needs = "Build"
  uses = "./.github/node-chrome"
  runs = "sh -c"
  args = ["npm run e2e -- --configuration=ci"]
}
