from __future__ import annotations

import sys
from argparse import ArgumentParser as ArgParseArgumentParser
from argparse import Namespace as ArgParseNamespace
from typing import List
from typing import Optional

from .configuration import LinkerConfiguration


class LinkerArgumentParser:
    PROG_NAME: str = 'dotfile_linker'

    PROG_DESCRIPTION: str = 'Dotfile linker...'

    @classmethod
    def _generate_parser(cls) -> ArgParseArgumentParser:
        parser: ArgParseArgumentParser = ArgParseArgumentParser(
            prog=cls.PROG_NAME,
            description=cls.PROG_DESCRIPTION
        )

        parser.add_argument('--dotfile', dest='dotfile', type=str,
                            action='store', required=True)

        parser.add_argument('--source-file', dest='source_file', type=str,
                            action='store', required=False, default=None)

        parser.add_argument('--source-location', dest='source_location',
                            type=str, action='store', required=False,
                            default=None)

        parser.add_argument('--target-file', dest='target_file', type=str,
                            action='store', required=False, default=None)

        parser.add_argument('--target-location', dest='target_location',
                            type=str, action='store', required=False,
                            default=None)

        parser.add_argument('--config', dest='config', type=str,
                            action='store', required=False, default=None)
        return parser

    @classmethod
    def _get_config(
            cls, arguments: ArgParseNamespace
    ) -> LinkerConfiguration:
        return LinkerConfiguration(
            dotfile=arguments.dotfile,
            source_file=arguments.source_file,
            source_location=arguments.source_location,
            target_file=arguments.target_file,
            target_location=arguments.target_location,
            config_path=arguments.config
        )

    @classmethod
    def parse(
            cls, args: Optional[List[str]] = None
    ) -> LinkerConfiguration:
        args = args if args is not None else sys.argv[1:]
        parser: ArgParseArgumentParser = cls._generate_parser()
        arguments: ArgParseNamespace = parser.parse_args(args=args)
        configuration: LinkerConfiguration = cls._get_config(arguments)
        return configuration
