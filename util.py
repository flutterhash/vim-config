#!/usr/bin/env python3
# PYTHON_ARGCOMPLETE_OK

#Copyright © 2015-2016 Thia Wyrod <thia@wyrod.ca>
#All rights reserved.
#Licensed under the 3-clause BSD License: see the included LICENSE file.

import argparse, argcomplete
import os, subprocess, shlex, shutil, re


def subprocess_exec(cmd):
  subprocess.call(shlex.split(cmd), stderr=subprocess.STDOUT)


def update_all():
  base_dir = os.getcwd()
  # We only wish to track remotes on our immediate repositories; they may
  # have their own submodules of specific commits
  subprocess_exec('git submodule update --init --remote')
  dir_list = [ d.path for d in os.scandir(os.path.join(base_dir, 'bundle'))
    if d.is_dir() ]
  for d in dir_list:
    if os.path.exists(os.path.join(d, '.gitmodules')):
      os.chdir(d)
      subprocess_exec('git submodule update --init --recursive')
  os.chdir(base_dir)


def rebuild_ycm(num_cores):
  c_dir = os.getcwd()
  os.chdir(os.path.join(c_dir, 'bundle/YouCompleteMe'))
  os.environ['YCM_CORES'] = num_cores
  build_cmd = './install.py --clang-completer --system-libclang --racer-completer'
  subprocess_exec(build_cmd)
  del os.environ['YCM_CORES']
  os.chdir(c_dir)


def rebuild_color_coded(num_cores):
  c_dir = os.getcwd()
  src_dir = os.path.join(c_dir, 'bundle/color_coded')
  build_dir = '/tmp/builds/color_coded-temp'
  os.makedirs(build_dir, exist_ok=True)
  os.chdir(build_dir)
  cmake_vars = [ '-DCUSTOM_CLANG=1', '-DLLVM_ROOT_PATH=/usr',
    '-DLLVM_INCLUDE_PATH=/usr/lib/llvm-3.8/include'
  ]
  subprocess_exec('cmake {1} {0}'.format(' '.join(cmake_vars), src_dir))
  subprocess_exec('make -j{0}'.format(num_cores))
  subprocess_exec('make install')
  os.chdir(c_dir)
  shutil.rmtree(build_dir)


def rebuild_all():
  num_cores = subprocess.check_output(shlex.split('grep -c ^processor /proc/cpuinfo'))
  num_cores = str(num_cores.strip(b'\n').strip(), encoding='ascii')
  rebuild_color_coded(num_cores)
  rebuild_ycm(num_cores)


def safe_gen_link(target, link):
  try:
    if os.path.exists(link):
      os.unlink(link)
    os.symlink(target, link)
  except:
    print('Failed symlink generation: {0} pointing at {1}'.format(link, target))


def install_all():
  os.makedirs('autoload', exist_ok=True)
  os.makedirs('.cache', exist_ok=True)
  pathogen_f = os.path.join(os.getcwd(), 'pathogen/autoload/pathogen.vim')
  safe_gen_link(pathogen_f, 'autoload/pathogen.vim')
  base_dir = os.path.join(os.getcwd(), 'dotfiles')
  for d in os.walk(base_dir):
    for f in d[2]:
      path = os.path.join(d[0], f)
      link_path = re.sub(base_dir, os.environ['HOME'], path)
      safe_gen_link(path, link_path)


kValidCmds = {
  'update': update_all,
  'rebuild': rebuild_all,
  'install': install_all,
}


def parse_argv():
  parser = argparse.ArgumentParser(
    description='Easily update git submodule-managed plugins'
  )
  parser.add_argument('cmds', action='store', default=None,
    nargs='+', choices=kValidCmds.keys(),
    help=''
  )
  argcomplete.autocomplete(parser)
  return parser.parse_args()


if __name__ == '__main__':
  argv = parse_argv()
  for cmd in argv.cmds:
    kValidCmds[cmd]()
