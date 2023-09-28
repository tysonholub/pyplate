# Install poetry dependencies and pre-commit git hooks
install:
    #!/bin/bash
    set -euxo pipefail

    poetry install

    if [[ -L .git/hooks ]]; then
        echo -e "\e[32mRemoving existing .git/hooks symlink\e[0m"
        rm .git/hooks
    fi

    if ! command -v pre-commit > /dev/null; then
        echo -e "\e[31mpre-commit must be installed. See README.md\e[0m"
        exit 1;
    fi

    echo -e "\e[32m$(pre-commit install --install-hooks)\e[0m"


# Fetch latest changes from the boilerplate remote. Optionally specify a boilerplate branch to pull from
update_boilerplate branch="main":
    #!/bin/bash
    set -euxo pipefail

    if [[ -n $(git status -s) ]]; then
        echo -e "\e[31mCommit or discard changes before pulling from the boilerplate.\e[0m"
        exit 1;
    fi

    if git remote -v | grep origin | grep "/boilerplate.git " > /dev/null; then
        echo -e "\e[31mYou can't update the boilerplate from itself.\e[0m"
        exit 1;
    fi

    git fetch boilerplate {{branch}}
    git pull --rebase=false --no-ff boilerplate {{branch}} || true

    echo -e "\e[32mBoilerplate changes staged for commit. Resolve any conflicts and run 'git commit'.\e[0m"


# Run pytest with coverage report
test path="":
    #!/bin/bash
    set -euxo pipefail

    poetry run coverage run -m pytest {{path}} -vv
    poetry run coverage report -m
    poetry run coverage html
