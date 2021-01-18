from __future__ import annotations

import os
from pathlib import Path
from typing import Optional


class Dotfile:
    def __init__(self, dotfile: str, source_file: Optional[str] = None,
                 source_location: Optional[str] = None,
                 target_file: Optional[str] = None,
                 target_location: Optional[str] = None):
        self._dotfile: str = dotfile

        if source_file is None:
            source_file = f'{dotfile}'

        self._source_file: str = source_file

        if source_location is None:
            source_location = f'{dotfile}'

        self._source_location: str = os.path.abspath(source_location)

        if target_file is None:
            target_file = f'.{source_file}'

        self._target_file: str = target_file

        if target_location is None:
            target_location = Path.home()

        self._target_location: str = os.path.abspath(target_location)

    source: str = property(
        fget=lambda self: os.path.join(self._source_location,
                                       self._source_file)
    )

    target: str = property(
        fget=lambda self: os.path.join(self._target_location,
                                       self._target_file)
    )

    def __repr__(self):
        return ', '.join(
            k.strip('_') + '=' + str(v) for k, v in self.__dict__.items() if
            v is not None)
