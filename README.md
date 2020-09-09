# RaeTheme for gtk and kvantum engine
pallette.txt contains pallette information. The theme is edited from matcha-azul, pallette.txt contains the old values for each pallette color
run sassc gtk.scss gtk.css in the gtk3 theme to generate css from scss
run render-assets.sh in gtk3/gtk2 theme folder to rerender assets from the svg
use gentheme.sh to automate the above and create installable theme directories

After editing scss files, you can reinstall by doing:
rm OutputThemes -R; ./gentheme.sh; rm ~/.themes/RaeTheme* -R; cp ./OutputThemes/Gtk/RaeTheme* ~/.themes -r
