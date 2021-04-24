import os
dirName = __file__.strip("\servertest2.py")
for (dirpath, dirnames, filenames) in os.walk(dirName):
    print("1")
    print(dirpath,dirnames,filenames)