pushd %~dp0..
set A=%CD%
popd

docker run --name feappv5_1 -it -v %A%:/feappv/decks/ feappv-dev