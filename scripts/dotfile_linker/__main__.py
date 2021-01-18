from __future__ import annotations

from typing import Optional

from dotfile_linker.core import Dotfile
from dotfile_linker.core import DotfileLinker
from dotfile_linker.core import DotfileLinkerArgumentParser
from dotfile_linker.core import DotfileLinkerConfiguration
from dotfile_linker.core import DotfileLinkerLogger


def main() -> None:
    logger: DotfileLinkerLogger = DotfileLinkerLogger()
    config: DotfileLinkerConfiguration = DotfileLinkerArgumentParser.parse()

    logger.debug(f'parsed config: {config}')

    dotfile: Dotfile = Dotfile(**config.dotfile_configuration)

    logger.debug(f'generated dotfile: {dotfile}')

    config_path: Optional[str] = config.config_path

    linker: DotfileLinker
    if config_path is not None:
        with open(config_path, 'r') as yaml_file:
            linker = DotfileLinker.from_yaml(yaml_file)
    else:
        linker = DotfileLinker()

    logger.debug(f'initialized linker: {linker}')

    logger.info(
        f'linking {DotfileLinkerLogger.Color.VIOLET.value}{dotfile.source}'
        f'{DotfileLinkerLogger.Color.END.value} -> '
        f'{DotfileLinkerLogger.Color.VIOLET.value}{dotfile.target}'
        f'{DotfileLinkerLogger.Color.END.value}'
    )

    linker.link(dotfile.source, dotfile.target)


if __name__ == '__main__':
    main()
