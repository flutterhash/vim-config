import os
proj_root = os.getcwd()
while ( not(os.path.exists(proj_root+'/.git')) and not(proj_root == '/') ):
  proj_root = os.path.dirname(proj_root)
Iroot = '-I' + proj_root

flags = [
'-Wall',
'-werror',
Iroot,
'-std=c11',
'-pthread',
'-x',
'c'
]
def FlagsForFile( filename ):
  return {
    'flags': flags,
    'do_cache': True
  }
