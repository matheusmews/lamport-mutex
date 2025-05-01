#!/usr/bin/env bash

OUTFILE="results.csv"
echo "Version,Threads,Repetitions,RealTime(s),Result" > $OUTFILE

# Function: run_test <type> <reps> <threads>
run_test() {
    type=$1
    reps=$2
    threads=$3

    if [ "$type" = "lamport" ]; then
        bin="./run_lamport.out"
        cmd="LD_LIBRARY_PATH=. $bin $reps $threads"
    else
        bin="./run_pthread.out"
        cmd="$bin $reps $threads"
    fi

    echo "Running: $type with $threads threads × $reps repetitions..."

    # Use /usr/bin/time to get real execution time in seconds (e.g., 2.183)
    tmp_output=$(mktemp)
    tmp_time=$(mktemp)

    /usr/bin/time -f "%e" -o "$tmp_time" bash -c "$cmd" > "$tmp_output"

    result=$(grep "Global var" "$tmp_output" | awk '{print $3}')
    realtime=$(cat "$tmp_time")

    echo "$type,$threads,$reps,$realtime,$result" >> $OUTFILE

    rm -f "$tmp_output" "$tmp_time"
}

# Example test cases
run_test lamport 9000000 1
run_test pthread 9000000 1
run_test lamport 4000000 2
run_test pthread 4000000 2
run_test lamport 3000000 3
run_test pthread 3000000 3
run_test lamport 3000000 4
run_test pthread 3000000 4
run_test lamport 1000000 8
run_test pthread 1000000 8

echo "Test results saved to $OUTFILE"
