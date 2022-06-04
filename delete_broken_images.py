import os
import argparse
from PIL import Image

# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-f", "--folder", required=True,
        help="path to the images")
args = vars(ap.parse_args())

for filename in os.listdir(args["folder"]):
    if filename.endswith(".jpg"):
        f = os.path.join(args["folder"], filename)
        # checking if it is a file
        if os.path.isfile(f):
            try:
                im = Image.open(f)
                verify = im.verify()
            except:
                print(f'{f} has errors, deleting it...')
                os.remove(f)
