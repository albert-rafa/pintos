#!/bin/bash

THREAD_BUILD_PATH="/home/rafa/ufpe/so/pintos/src/threads/build"
TESTS_SUBPATH="tests/threads"
CUR_DIR=$(pwd)

DEFAULT_THREAD_TESTS=(
  alarm-single
  alarm-multiple
  alarm-simultaneous
  alarm-priority
  alarm-zero
  alarm-negative
  priority-change
  priority-preempt
  priority-fifo
  priority-sema
  priority-condvar
  priority-donate-one
  priority-donate-multiple
  priority-donate-multiple2
  priority-donate-nest
  priority-donate-chain
  priority-donate-sema
  priority-donate-lower
  mlfqs-load-1
  mlfqs-load-60
  mlfqs-fair-2
  mlfqs-fair-20
  mlfqs-nice-2
  mlfqs-nice-10
  mlfqs-recent-1
  mlfqs-load-avg
  mlfqs-block
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