#!/bin/bash
echo "=============================================================="
echo "Tagging current application for rollbaack purpose as neede"
echo "=============================================================="
docker tag naapholey/tech-flow:latest naapholey/tech-flow:previous_stable
docker push naapholey/tech-flow:previous_stable