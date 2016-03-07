#!/usr/bin/python3
import os, re, subprocess, shlex, traceback

kSubmoduleDecl = re.compile('\\[submodule ".*"\\]')
kPathDecl = re.compile('\\s*path = (.*)')
kUrlDecl = re.compile('\\s*url = (.*)')
kBranchDecl = re.compile('\\s*branch = (.*)')

submodule_file = open('.gitmodules')

while True:
  submod_str = submodule_file.readline()
  if submod_str == '': #end of file
    exit(0)
  if not kSubmoduleDecl.match(submod_str):
    continue
  try:
    path = kPathDecl.match(submodule_file.readline()).group(1)
    url = kUrlDecl.match(submodule_file.readline()).group(1)
    branch = kBranchDecl.match(submodule_file.readline()).group(1)
  except:
    traceback.print_exc()
    continue
  subprocess.call(shlex.split('git submodule add -b {br} {url} {path}'.format(br=branch, url=url, path=path)))
