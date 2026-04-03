#!/bin/bash

echo "Running tests..."

if [ ! -f build/main ]; then
    echo "Build failed: binary not found"
    exit 1
fi

./build/main <<EOF
0
EOF

if [ $? -ne 0 ]; then
    echo "Program failed to run"
    exit 1
fi

echo "All tests passed!"