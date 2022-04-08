import os
import base64
import pandas as pd

def split_len(seq, length):
    return [seq[i:i + length] for i in range(0, len(seq), length)]

DIRs = ['.\mediaportal-uk-logos-master\TV\.Light',
        '.\mediaportal-uk-logos-master\Radio\.Light']
source = 'mediaportal-uk-logos'

myarray = []

for directory in DIRs:
    for r, d, f in os.walk(directory):
        for file in f:
            filename, filetype = file.split(".", 1)
            with open(directory + "\\" + file, "rb+") as image_file:
                data = str(base64.standard_b64encode(image_file.read()), 'utf-8')
                data = "\n".join(split_len(data, 72))
                item = [filename, filetype, data, source]
                myarray.append(item)

dfImages = pd.DataFrame(myarray, columns=['ImageName','ImageType','Base64Image','ImageSource'])

dfChannelList = pd.read_csv('ChannelList.csv')

df = pd.merge(dfChannelList, dfImages, how='left', left_on='ImageRef', right_on='ImageName')

# Channels not matching Image
df[df.isna().any(axis=1)]

f = open("smartremote.xml", "w")

f.write("<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>\n")
f.write("<SmartTVChannels>\n")

for index, row in df.iterrows():
    channelName = row['Name']
    channelNo = row['ChannelID']
    Image64 = row['Base64Image']
    Image64 = str(Image64)
    #Image64 = textwrap.fill(Image64, 72)
    f.write('<channel channel_id=\"' + channelName + '\" channel_list_number=\"' + str(channelNo) + '\">' + Image64 + '\n')
    f.write('</channel>\n')
f.write("</SmartTVChannels>\n")
f.close()