#!/bin/bash

# Default values
Backends=("uvgRTP" "live555")
WrapperName="RTPBurrito"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -b|--backends)
      # Set the list of backends from the provided argument
      shift
      Backends=("$@")
      shift
      ;;
    -w|--wrapper)
      # Set the wrapper name from the provided argument
      shift
      WrapperName="$1"
      shift
      ;;
    *)
      # Unknown argument
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Create the main folder structure
mkdir -p $WrapperName
cd $WrapperName

# Create CMakeLists.txt
echo "project($WrapperName)" > CMakeLists.txt

# Create the 'inc' folder and the wrapper header file
mkdir -p inc
touch inc/${WrapperName}Wrapper.h

# Create the 'backends' folder and subfolders for each backend
mkdir -p backends
for backend in "${Backends[@]}"; do
  mkdir -p backends/$backend/rpo
  mkdir -p backends/$backend/examples
done

# Exit the 'inc' folder
cd ..
