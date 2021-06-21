import os
import sys
###Given a file of accession ids grouped by biosample download all the bam files
name=sys.argv[1]
file = open(name, 'r')
dir =sys.argv[2]

for line in file.readlines()[1:]:
    c_ac = line.split('\t')[2]
    bio_name = line.split('\t')[1]
    #c_bio = line.split('')[2]
    me1_ac = line.split('\t')[3]
    me3_ac = line.split('\t')[4]
    ac27_ac = line.split('\t')[5]

    #print(ac27_ac+"do we have a line break?")
    # #python ENCODE_downloader/encode_downloader.py $1 --file-types "bam:alignments" --dir $2
    print("Making the directories for: "+bio_name)
    os.system("mkdir "+dir+bio_name)
    dir0 = dir+bio_name+"/Controls/"
    dir1 = dir+bio_name+"/H3K4me1/"
    dir2 = dir+bio_name+"/H3K4me3/"
    dir3 = dir+bio_name+"/H3K27ac/"
    os.system("mkdir "+dir0)
    os.system("mkdir "+dir1)
    os.system("mkdir "+dir2)
    os.system("mkdir "+dir3)

    # ###add that you only want hg38 assembly
    # # ##
    cmd1 = "python encode_downloader.py "+c_ac+" --file-types ""bam:alignments"" --dir "+dir0
    cmd2 = "python encode_downloader.py "+me1_ac+" --file-types ""bam:alignments"" --dir "+dir1
    cmd3 = "python encode_downloader.py "+me3_ac+" --file-types ""bam:alignments"" --dir "+dir2
    cmd4 = "python encode_downloader.py "+ac27_ac+" --file-types ""bam:alignments"" --dir "+dir3
    print("Downloading Controls ...")
    os.system(cmd1)
    print("Downloading H3K4me1...")
    os.system(cmd2)
    print("Downloading H3K4me3...")
    os.system(cmd3)
    print("Downloading H3K27ac...")
    os.system(cmd4)
    print(" ")
    print("Finished downloading all files for : "+bio_name)
    print("Moving on to next entry")
