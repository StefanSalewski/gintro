cd
#git clone https://github.com/stefansalewski/gintro.git
mkdir gintrotest
mkdir gintrotest/test
cd gintrotest/test
mkdir nim_gi
cp ~/gintro/tests/* .
wget https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/gobject.nim -O gobject.nim
wget https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/glib.nim -O glib.nim
wget https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/gir.nim -O gir.nim

# nim c gen.nim
# ./gen # gtk3 -- for latest version, we have to generate gtk3 files first!
# ./gen 1 # gtk4 


