
# SputNix

> Welcome to the Sput*Nix* Repository.

This Repository aims to solve one problem: Getting started with NixOS is extremely tedious. The documentation is often really shallow and it's all scattered throughout the internet like a broken vase.

SputNix aims to be a one-stop shop for all the basics that you need in order to have a functional configuration at the start of your NixOS journey with all the features you would have otherwise found yourself rewriting your configuration in order to accommodate, like Flakes, Home-manager or Disko, while also explaining what these are, why you want them and how to modify them to your preference.

It is best if you know some Linux basics and how to navigate a terminal user interface, but this is not required. You should however learn Git as it will make your life much easier, but you can learn it as you go. If you'd rather know before hand what your getting into you can read these short introductions to [Git](./assets/git-basics) and the [terminal](./assets/terminal) that I wrote, Else go to the [Installation](./assets/installation)

so you might not be entirely sold on investing a few afternoons to get comfortable with a Nix system. You probably have a question and that question is probably:

### Why Nix?

The way most people initially hear about NixOS is that it is an *immutable* distro. What this usually means is that (most) the filesystem is read-only. This has many benefits and downsides, but it doesn't accurately describe what NixOS actually does. A more accurate word to describe NixOS is that it is *declarative*.

Nix, *the Linux distribution*, is really just the implementation of Nix, *the package manager*, on a larger scale, using Nix, *the programming language*, to configure the entire system, giving you the full ***Nix*** experience without compromise. In more simpler terms - NixOS is a Linux distribution based on the Nix package manager, like debian with APT. It *is* an immutable distro, but it can be fully configured like normal distros by using the Nix programming language instead of editing files in `/etc` directly.

By fully leaning into the non standard design implementations it gains even more features with less cost than the sum of their downsides, with the caveat being that any configuration and package management is mediated through the ***Nix*** ecosystem. The most notable features being:

- ***No dependency hell***. Each package is built in isolation and has it's own dependencies.  When a program needs a new dependency, it simply gets rebuild with a symlink to the new dependency, No packages are removed. Any shared dependencies are just symlinks to the specific package, so no space is wasted.
- ***Plenty of packages***. The nixpkgs repository is the largest package repository in the world, having over a 100'000 packages. You won't ever have to look at another package manager again!
- ***Stable***. The stability of a package manager really boils down to two things: Whether or not its is running ustable/experimental builds of packages / allows for major updates inside a release cycle, and how well the dependency conflicts are handled. Since Nix eliminates the latter, all you have to do to run a stable system is to use the stable channel and Nix takes care of the rest.
- ***Bleeding edge***. The nixpkgs-unstable channel is a rolling release channel that sports the most up-to-date packages in the Linux world, making sure you have access to the newest packages of everything. With flakes you can run both the stable and the unstable channels at the same time allowing you to use the stable for programs that cannot break and the unstable for programs that need the newest updates.
- ***Atomic upgrades***. Updates in Nix either happen fully, or not at all. With each package being uniquely identified by their hash, new ones don't override old ones, so if something goes wrong during an update you aren't left with a broken system.
- ***Rollbacks***. With Nix you can rollback to all your previous configurations, meaning that if an update contains a broken package or an experimental change you don't like, you can just revert to the state before the update as if it never happened.
- ***Configuration files***. The entirety of your system is configured through configuration files making managing your system incredibly easy and everything you do is self documenting, so no need to look up those commands you always forget, just read your code.
- ***Reproducible***. Since everything about your system is stored in a single git repository, sharing your system with others is as easy as sending them zip file or a link to a remote repository. And with flakes, everything is guaranteed to be an exact replication, down to the exact commit of each package.
- ***Dynamic environments***. Nix gives you access to the Nix shell which is an environment where you can specify whatever packages you want and use them for the duration of the shell. If you have Python3.x on your system, but for a specific task you need Python3.y, then all you have to do is initiate a shell with Python3.y and it will be gone when you leave the shell.
- ***Purely functional***. Nix is a declarative, purely functional language. This means that functions have no effect on external state. This may take some time getting used to, but it allows the interpreter to make a whole bunch of assumptions which is the key to its reproducible nature. This also forces you into a pattern that rarely produces bugs, keeping your system stable.
- ***Lazily evaluated***. Nix only evaluates values if they are called. Any errors like divisions by zero and anything that would take eons to compute is not calculated unless it is needed. You don't pay for what you don't use.

With a feature set like this it can be hard to not see the appeal.
