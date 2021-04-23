pushd %~dp0..
set A=%CD%
popd

cd %A%

make clean