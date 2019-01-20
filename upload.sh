#!/bin/bash
read -p "Please give a commit description: " desc
git add -A && \
git commit -m "$desc" && \
git push -u origin master && \
echo "Script has run successfully"