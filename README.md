# pyplate

## Overview

A boilerplate for Python 3 projects

-   Styles code with [black](https://github.com/psf/black)
-   Lints code with [flake8](https://github.com/PyCQA/flake8)
-   Sorts imports with [isort](https://github.com/PyCQA/isort)
-   Validates git commits (and/or formats changes) with [pre-commit](https://github.com/pre-commit/pre-commit)
-   Configures VSCode to use black, flake8, isort, etc. You'll want to install the recommended VSCode extensions, when prompted, as defined in `.vscode/extensions.json`

## Dev Prerequisites

-   python 3.12
-   [pipx](https://pypa.github.io/pipx/), an optional tool for prerequisite installs
-   [poetry](https://github.com/python-poetry/poetry) (install globally with `pipx install poetry`)
-   [flake8](https://github.com/PyCQA/flake8) (install globally with `pipx install flake8`)
    -   [flake8-bugbear](https://github.com/PyCQA/flake8-bugbear) extension (install with `pipx inject flake8 flake8-bugbear`)
    -   [flake8-naming](https://github.com/PyCQA/pep8-naming) extension (install with `pipx inject flake8 pep8-naming`)
-   [black](https://github.com/psf/black) (install globally with `pipx install black`)
-   [pre-commit](https://github.com/pre-commit/pre-commit) (install globally with `pipx install pre-commit`)
-   [just](https://github.com/casey/just), a Justfile command runner

### Windows

Justfile support for Windows requires [cygwin](https://www.cygwin.com/). Once installed your `PATH` will need to be updated to resolve `cygpath.exe` (probably `C:\cygwin64\bin`). Justfile will forward any targets with shebangs starting with `/` to cygwin for execution.

## Updating python version:

-   Update python version in `Dev Prerequisites` above
-   Update \[tool.poetry.dependencies\] section of `pyproject.toml`
-   Update pyupgrade hook in `.pre-commit-config.yaml`

## Justfile Targets

-   `install`: installs poetry dependencies and pre-commit git hooks
-   `update_boilerplate`: fetches and applies updates from the boilerplate remote
-   `test`: runs pytest with test coverage report

## Usage

To start a new project, clone this repository, then rename the `origin` remote to `boilerplate`

```bash
git remote rename origin boilerplate
```

Then add your new remote `origin`

```bash
git remote add origin <remote repository>
```

Remove and replace (or rename) the `pysrc/pyplate` module to start your new project. Be sure to also replace `pyplate` references in `pyproject.toml` with your new module / project name.

You can also add this repository to an existing project as the `boilerplate` remote:

```bash
git remote add boilerplate git@github.com:tysonholub/pyplate.git
```

The following should help apply the boilerplate history into an existing project. Depending on your existing project structure, you may want to move everything into a backup/ folder first, then refactor accordingly after merging the boilerplate remote.

```bash
git merge boilerplate/main --no-ff --allow-unrelated-histories
```

Then moving forward, run `just update_boilerplate` to pull latest changes from the `boilerplate` remote. **NOTE**: you must keep the boilerplate remote history intact to successfully merge updates from the boilerplate remote.
