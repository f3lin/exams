#!/bin/bash

# Set variables
URL=" https://github.com/cert-manager/cert-manager/releases/download/v1.0.4/kubectl-cert_manager-linux-amd64.tar.gz"
FILE="kubectl-cert-manager.tar.gz"
DEST="/usr/local/bin/"

# Download the file
echo "Downloading kubectl-cert-manager..."
if curl -L -o "$FILE" "$URL"; then
    echo "Download successful."
else
    echo "Error downloading file." >&2
    exit 1
fi

# Verify the file type
echo "Checking file format..."
if file "$FILE" | grep -q 'gzip compressed data'; then
    echo "File format is correct."
else
    echo "File is not in gzip format." >&2
    exit 1
fi

# Extract the file
echo "Extracting kubectl-cert-manager..."
if tar -xzf "$FILE"; then
    echo "Extraction successful."
else
    echo "Error extracting file." >&2
    exit 1
fi

# Move to /usr/local/bin
echo "Installing kubectl-cert-manager..."
if sudo mv kubectl-cert_manager "$DEST"; then
    echo "Installation successful."
else
    echo "Error during installation." >&2
    exit 1
fi

# Clean up
echo "Cleaning up..."
rm "$FILE"

echo "kubectl-cert-manager is installed successfully."
