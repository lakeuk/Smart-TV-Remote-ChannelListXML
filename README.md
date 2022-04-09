# Smart-TV-Remote-ChannelListXML
Script to generate a channel list XML that can be imported into Android app - Smart TV Report

App - https://play.google.com/store/apps/details?id=com.adi.remote.phone&hl=en_GB

![Alt text](./README-assets/smartremote-01.jpg?raw=true "Smart Remote")

#### ChannelList.csv  
Set channel numbers, names, image names

#### smartremote.py  
Standalone python script to generate xml output that's used as the import xml for the app

#### smartremote notebook.ipynb  
JupyterLab notebook version of python script, will also list channels in csv file without a matching image file

#### mediaportal-uk-logos-master folder  
location to place files taken from zip sourced at https://github.com/Jasmeet181/mediaportal-uk-logos

#### smartremote.xml  
last sample file generated from make_smartremoteXML.pl
  copy over to folder on phone, import through remote app

Instructions

Unzip latest uk mediaportal logos to 'mediaportal-uk-logos-master' folder
Update ChannelList.csv with any channel changes and/or new image names
Run python script to generate new smartremote.xml
Copy smartremote.xml over to android phone with app into smarttv_channels folder
Open app on phone
Go into settings, select Import/Export Channels
For Import filename type smartremote.xml 
Tick 'Clear channels before import'
Press Import button
Import succeeded! will display if import has worked, press back button until your back to the channel list to see the result

![Alt text](./README-assets/smartremote-02.jpg?raw=true "Smart Remote")
![Alt text](./README-assets/smartremote-03.jpg?raw=true "Smart Remote")
