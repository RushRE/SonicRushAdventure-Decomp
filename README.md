# Sonic Rush Adventure
[![CI status][ci-badge]][ci-status-link] [![Contributors][contributors-badge]][contributors-link] [![Discord][discord-badge]][discord-link]

[ci-status-link]: https://github.com/RushRE/SonicRushAdventure-Decomp/actions/workflows/build.yml
[ci-badge]: https://github.com/RushRE/SonicRushAdventure-Decomp/actions/workflows/build.yml/badge.svg

[contributors-link]: https://github.com/RushRE/SonicRushAdventure-Decomp/graphs/contributors
[contributors-badge]: https://img.shields.io/github/contributors/RushRE/SonicRushAdventure-Decomp

[discord-badge]: https://img.shields.io/discord/1217789729739636746
[discord-link]: https://discord.gg/EnYXZGrk6V

This is a work in progress matching decompilation of Sonic Rush Adventure for the Nintendo DS. For instructions on how to set up the repository, please read [INSTALL.md](INSTALL.md).

This repository builds the following ROM:

* [**rush2.eu.nds**](https://datomatic.no-intro.org/index.php?page=show_record&s=28&n=1403) `sha1: f105f64da60d7e0544a96b7c4c945b07fc5fa8a2`

* Europe (rev01), USA & JP ROM support is planned in the future, but aren't a priority at the moment.

### Current state

- :warning: The build is NOT shiftable. You can make _some_ modifications, but most aspects of the game will currently cease to function.
- Most of the game's assembly code [extracted, disassembled, and somewhat categorised](./asm/)
- Most library functions have been named, though most of the library C code has not been decompiled.

### What's left to do
- research any functions and modules that are using `_XXXXXX` suffixes and give them proper names
- properly split asm files into respective `.c` files. This includes proper `.text`, `.bss`, `.data` & `.rodata` sections
- replace as many hardcoded addresses with proper labels to allow the game to be more shiftable
- split the library files from the game logic, with the eventual goal to have them as compiled `.a` static libraries
- decompile all functions into proper `.c` & `.h` files
- match all existing non-matching game logic functions
- upgrade build system to convert most binary files into user-friendly formats on extraction, and repack them into their respective binary forms on compilation
- document differences in the JP & USA rom's code and add those differences into the codebase in a form that allows them to build matching
- setup build system to build competition rom (`files/mb/contest.srl`)

**Provide assets**

You must have a copy of the Sonic Rush Adventure ROM named `baserom.nds` in the repository root directory. Any Sonic Rush Adventure ROM should be fine, as the game shares most assets between versions.

### Community

Join us on [discord](https://discord.gg/EnYXZGrk6V) to get started in helping out, to discuss the decompilation, or just to hang out!

### Credits

- [Pokemon Reverse Engineering Team](https://github.com/pret) for tooling for NDS decompilations
- [The Sonic 4 - Episode 1 Decompilation](https://github.com/WanKerr/Sonic4Episode1) which was used as a reference for various modules that both games share
- [Sonic Advance Trilogy Research Team](https://discord.gg/vZTvVH3gA9) for their Sonic Advance 2 Decompilation, which was the inspiration this project
