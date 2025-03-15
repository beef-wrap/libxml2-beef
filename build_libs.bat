mkdir libs
mkdir libs\debug
mkdir libs\release

mkdir libxml2\build
cd libxml2\build

cmake -DBUILD_SHARED_LIBS=OFF -DLIBXML2_WITH_ICONV=OFF ..

cmake --build .
copy Debug\libxml2sd.lib ..\..\libs\debug
copy Debug\libxml2sd.pdb ..\..\libs\debug

cmake --build . --config Release
copy Release\libxml2s.lib ..\..\libs\release