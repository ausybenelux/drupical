# Drupical

Drupical is an easily configurable Vagrant box for developing Drupal projects.

## Quickstart

## Installation

### Including Drupical in your Project

Drupical should be set up as a sub directory of your project's repository. Ideally your repository looks like this:

- docroot (your Drupal code)
- vagrant (the Drupical code)
- ... (other project files and directories)

Follow these steps for inlcuding the latest version of Drupical in your project:

```bash
cd /to/your/project/dir/root
```
```bash
git clone --depth=1 git@github.com:ONEAgency/drupical.git vagrant && rm -rf vagrant/.git
```

You can also add Drupical as a submodule if you want to keep track of changes:

```bash
git submodule add git@github.com:ONEAgency/drupical.git vagrant
```

### Configuring Drupical for your Project

### Provisioning the Vagrant Box

## Usage

## Configuration

## Troubleshooting

## Contributing

https://github.com/applicationsonline/librarian-chef
