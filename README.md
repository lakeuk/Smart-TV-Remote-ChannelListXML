# Smart-TV-Remote-ChannelListXML
Script to generate a channel list XML that can be imported into Android app - Smart TV Report

App - https://play.google.com/store/apps/details?id=com.adi.remote.phone&hl=en_GB


image_insert.pl
  takes each png image in tvlogos folder, converts into base64 and loads into database

make_smartremoteXML.pl
  extract from database, channel number, name, base64 image
  generate xml

smartremote.db
SQLite database, contains table holding base64 images and table for you to manage your channel listing 

smartremote.xml
  last sample file generated from make_smartremoteXML.pl
  copy over to folder on phone, import through remote app
