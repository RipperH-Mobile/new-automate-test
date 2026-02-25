#!/bin/bash

if [ ! -f integration_test/untracked_file_list.txt ]; then
    echo "Error: untracked_file_list.txt not found!"
    exit 1
fi

echo "Start untracked_file..."

while IFS= read -r file || [ -n "$file" ]; do
    if [[ -z "$file" || "$file" == \#* ]]; then
        continue
    fi
    git update-index --no-skip-worktree "$file"
    echo " -> Ignored: $file"
done < integration_test/untracked_file_list.txt

echo "Done!"