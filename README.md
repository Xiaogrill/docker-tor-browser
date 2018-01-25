# Dockerized Tor Browser

## Why?

Because an ephemeral filesystem makes sense in my threat model.

## Installation

Read `deploy.sh` and `tor` and maybe change `INSTALL_PREFIX` and `WORKDIR` respectively.

Run `./deploy.sh`.

## Usage

`tor` should now be in your $PATH. So, run `tor` from a terminal or dmenu et al (or make a tor.desktop shortcut).

## Dependencies

Docker, sudo, sakura (terminal for --no-interaction), curl, sha256sum, X.

Customize to your needs.

## Tips

This Docker setup assumes your user is not in the docker-group, and you are not root. It will try to use sudo to elevate your privileges - you can give your user NOPASSWD sudo access to the `tor` script. This should be "safe" since it takes no actual user input.

## Contributing

If you want to contribute, feel free to make a pull request on [Github](https://github.com/Xiaogrill/docker-tor-browser), please read [CONTRIBUTING](CONTRIBUTING) and [the license](UNLICENSE) first.
