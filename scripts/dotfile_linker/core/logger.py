from __future__ import annotations

import logging
import sys
from enum import Enum, unique

from .argument_parser import LinkerArgumentParser


class Logger:
    @unique
    class Color(Enum):
        END = '\033[0m'
        RED = '\033[91m'
        GREEN = '\033[92m'
        YELLOW = '\033[93m'
        BLUE = '\033[94m'
        VIOLET = '\033[95m'
        CYAN = '\033[96m'

    def __init__(self, level: int = logging.INFO):
        self._logger: logging.Logger = logging.getLogger(
            name=LinkerArgumentParser.PROG_NAME)
        self._logger.setLevel(level=level)

        handler: logging.Handler = logging.StreamHandler(sys.stdout)
        formatter: logging.Formatter = logging.Formatter(
            f'\t'
            f'{Logger.Color.VIOLET.value}'
            f'[ '
            f'{Logger.Color.CYAN.value}'
            f'%(name)s'
            f'{Logger.Color.VIOLET.value}'
            f' ] '
            f'{Logger.Color.YELLOW.value}'
            f'%(asctime)s'
            f'{Logger.Color.VIOLET.value}'
            f' - '
            f'{Logger.Color.END.value}'
            f'%(message)s'
        )
        handler.setFormatter(formatter)
        self._logger.addHandler(handler)

    def info(self, message: str):
        self._logger.info(message)

    def debug(self, message: str):
        pass
        # self._logger.debug(message)
