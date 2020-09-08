#!/bin/sh
# build script that first builds scss to css, renders assets from svg to pngs, and copies files to installable theme directories
OUTPUTDIR='OutputThemes'
SASSC=`/usr/bin/sassc`
REBUILD_ASSETS=false

echo "gen theme, -o changes output dir -r rebuilds assets in gtk themes"

while getopts o:r option
do
case "${option}"
in
o) OUTPUTDIR=${OPTARG};;
r) REBUILD_ASSETS=true;;
esac
done

if [ -d $OUTPUTDIR ]; then
	echo "Output Directory already exists, delete/move to regenerate"
	exit
fi

cd ./RaeTheme-gtk/src/gtk-3.0
if [ $REBUILD_ASSETS = true ] ; then
	rm ./assets/*.png
	./render-assets.sh
fi
rm ./*.css
sassc gtk.scss gtk.css
sassc gtk-dark.scss gtk-dark.css
cd ../gtk-2.0
if [ $REBUILD_ASSETS = true ] ; then
	rm ./assets/*.png
	rm ./assets-dark/*.png
	./render-assets.sh
fi
cd ../../../

mkdir $OUTPUTDIR
mkdir ./$OUTPUTDIR/Gtk
mkdir ./$OUTPUTDIR/Gtk/RaeTheme
mkdir ./$OUTPUTDIR/Gtk/RaeTheme/gtk-3.0
mkdir ./$OUTPUTDIR/Gtk/RaeTheme/gtk-3.0/assets
mkdir ./$OUTPUTDIR/Gtk/RaeTheme/gtk-2.0
mkdir ./$OUTPUTDIR/Gtk/RaeTheme/gtk-2.0/assets
mkdir ./$OUTPUTDIR/Gtk/RaeTheme-Dark
mkdir ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-3.0
mkdir ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-3.0/assets
mkdir ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-2.0
mkdir ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-2.0/assets
mkdir ./$OUTPUTDIR/Kvantum

# copy openbox themes
cp ./RaeTheme-gtk/src/openbox-3 ./$OUTPUTDIR/Gtk/RaeTheme/openbox-3 -R
cp ./RaeTheme-gtk/src/openbox-3 ./$OUTPUTDIR/Gtk/RaeTheme-Dark/openbox-3 -R

# copy gtk light themes
cp ./RaeTheme-gtk/src/gtk-3.0/assets/*.png ./$OUTPUTDIR/Gtk/RaeTheme/gtk-3.0/assets
cp ./RaeTheme-gtk/src/gtk-3.0/gtk.css ./$OUTPUTDIR/Gtk/RaeTheme/gtk-3.0/gtk.css
cp ./RaeTheme-gtk/src/gtk-3.0/gtk-dark.css ./$OUTPUTDIR/Gtk/RaeTheme/gtk-3.0/gtk-dark.css
cp ./RaeTheme-gtk/src/gtk-2.0/assets/*.png ./$OUTPUTDIR/Gtk/RaeTheme/gtk-2.0/assets
cp ./RaeTheme-gtk/src/gtk-2.0/gtkrc ./$OUTPUTDIR/Gtk/RaeTheme/gtk-2.0/gtkrc
cp ./RaeTheme-gtk/src/gtk-2.0/*.rc ./$OUTPUTDIR/Gtk/RaeTheme/gtk-2.0/


# copy gtk dark themes
cp ./RaeTheme-gtk/src/gtk-3.0/assets/*.png ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-3.0/assets
cp ./RaeTheme-gtk/src/gtk-3.0/gtk-dark.css ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-3.0/gtk.css
cp ./RaeTheme-gtk/src/gtk-3.0/gtk-dark.css ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-3.0/gtk-dark.css
cp ./RaeTheme-gtk/src/gtk-2.0/assets-dark/*.png ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-2.0/assets
cp ./RaeTheme-gtk/src/gtk-2.0/gtkrc-dark ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-2.0/gtkrc
cp ./RaeTheme-gtk/src/gtk-2.0/*.rc ./$OUTPUTDIR/Gtk/RaeTheme-Dark/gtk-2.0/


# copy kvantum themes
cp ./RaeTheme-kv/RaeTheme ./$OUTPUTDIR/Kvantum -R
cp ./RaeTheme-kv/RaeTheme-Dark ./$OUTPUTDIR/Kvantum -R
