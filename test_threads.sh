#!/bin/bash

THREAD_BUILD_PATH="/home/rafa/ufpe/so/pintos/src/threads/build"
TESTS_SUBPATH="tests/threads"
CUR_DIR=$(pwd)

DEFAULT_THREAD_TESTS=(
  alarm-single
  alarm-multiple
  alarm-simultaneous
  alarm-zero
)

if [ $# -eq 0 ]; then
  TESTS=("${DEFAULT_THREAD_TESTS[@]}")
else
  TESTS=("$@")
fi

cd "$THREAD_BUILD_PATH"

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
