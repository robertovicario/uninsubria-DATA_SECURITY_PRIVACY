| <img src="docs/theme/logo.svg" width="128"> |
| - |

# Data Security and Privacy, MSc Course @ University of Insubria

This repository contains my project work for the Data Security and Privacy course at the University of Insubria, part of the MSc in Computer Science.

## Overview

You can easily download my project work below, remember to use it responsibly and cite it if you reference it.

## Prerequisites

> [!IMPORTANT]
>
> - Pandoc

## Notes

| <a href="https://raw.githubusercontent.com/robertovicario/uninsubria-DATA_SECURITY_PRIVACY/main/dist/Project-Work.pdf"><img src="docs/theme/cover.png" alt="cover" height="256"></a> |
| - |

## Instructions

1. Usage:

```sh
bash cmd.sh <command>
```

2. Commands:

```sh
- [▶] notes
- [⚙] setup
```

### `setup`

If you haven't built the project yet, you can do so by running:

```sh
bash cmd.sh setup
```

### `notes`

The script will automatically generate the `content.pdf` file from the markdown files located in the `docs/md` directory and merge it with your `front.pdf` to create the final `Notes.pdf`:

```sh
bash cmd.sh notes
```

> [!IMPORTANT]
>
> Before running this command, ensure to upload your own `front.pdf` into the `dist` directory. You can even let `pandoc` generate a title page for you by updating the `titlepage` field in the `docs/md/__metadata__.yml` file, and removing the `front.pdf` reference from the `cmd.sh` script.

## Credits

> [!WARNING]
>
> Please use this project responsibly, it was created by me for an exam session that I completed at _University of Insubria_. If you use or reference this project, please cite it as follows:
>
> ```bib
> ...
> ```

## License

This project is distributed under <a href="https://creativecommons.org/licenses/by-nc-sa/4.0" target="_blank">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International</a>. You can find the complete text of the license in the project repository.
