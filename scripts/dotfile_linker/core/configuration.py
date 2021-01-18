from __future__ import annotations

from typing import Dict
from typing import Optional


class LinkerConfiguration:
    def __init__(self,
                 dotfile: str,
                 source_file: Optional[str] = None,
                 source_location: Optional[str] = None,
                 target_file: Optional[str] = None,
                 target_location: Optional[str] = None,
                 config_path: Optional[str] = None
                 ):
        self._dotfile: str = dotfile
        self._source_file: Optional[str] = source_file
        self._source_location: Optional[str] = source_location
        self._target_file: Optional[str] = target_file
        self._target_location: Optional[str] = target_location
        self._config_path: Optional[str] = config_path

    dotfile_configuration: Dict[str, Optional[str]] = property(
        fget=lambda self: {
            conf: getattr(self, f'_{conf}') for conf in
            {'dotfile', 'source_file', 'source_location', 'target_file',
             'target_location'}
        }
    )

    config_path: Optional[str] = property(
        fget=lambda self: getattr(self, '_config_path')
    )

    def __repr__(self):
        return ', '.join(
            k.strip('_') + '=' + str(v) for k, v in self.__dict__.items() if
            v is not None)
