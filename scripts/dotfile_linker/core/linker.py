from __future__ import annotations

import os
import shutil
from datetime import datetime
from typing import Any
from typing import Dict
from typing import Optional
from typing import TextIO

import yaml


class Linker:
    DEFAULT_EXTENSION: Optional[str] = 'save'

    @classmethod
    def from_yaml(cls, yaml_file: TextIO) -> Linker:
        conf: Dict[str, Any] = yaml.load(yaml_file, Loader=yaml.FullLoader)
        linker_conf: Dict[str, Any] = conf.get('linker', dict())
        return cls(**linker_conf)

    def __init__(self, archive: bool = True,
                 extension: Optional[str] = DEFAULT_EXTENSION,
                 timestamp: bool = True):
        self._archive: bool = archive
        self._extension: Optional[str] = extension
        self._timestamp: bool = timestamp

    def link(self, src_path: str, dst_path: str) -> None:
        if os.path.islink(dst_path):
            os.unlink(dst_path)
        elif os.path.exists(dst_path):
            if self._archive:
                dst_cpy: str = os.path.join(f'{dst_path}')
                if self._extension is not None:
                    dst_cpy = f'{dst_cpy}.{self._extension}'
                if self._timestamp:
                    date: str = datetime.now().strftime('%Y%m%d%H%M%S')
                    dst_cpy = f'{dst_cpy}{date}'
                shutil.move(dst_path, dst_cpy)

        os.symlink(src_path, dst_path)

    def __repr__(self):
        return ', '.join(
            k.strip('_') + '=' + str(v) for k, v in self.__dict__.items() if
            v is not None)
