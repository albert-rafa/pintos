#!/bin/bash

BUILD_PATH="/home/rafa/ufpe/so/pintos/src/userprog/build"
TESTS_SUBPATH="tests/userprog"
CUR_DIR=$(pwd)

DEFAULT_TESTS=(
  args-none
  args-single
  args-many
  args-multiple
)

if [ $# -eq 0 ]; then
  TESTS=("${DEFAULT_TESTS[@]}")
else
  TESTS=("$@")
fi

cd "$BUILD_PATH"

echo -e "\nRodando testes do PintOS..."

for TEST in "${TESTS[@]}"
do
  echo "-------------------------------------------"
  echo "Rodando: $TEST"

  rm -f "./$TESTS_SUBPATH/$TEST.output"
  make "./$TESTS_SUBPATH/$TEST.result"
done

echo "-------------------------------------------"
echo "Fim dos testes."

cd "$CUR_DIR"
