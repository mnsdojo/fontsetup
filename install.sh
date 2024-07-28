#!/bin/bash

# Project directory containing font zip files
FONT_DIR="$HOME/fontsetup/fonts"
# Directory where fonts will be installed
FONT_INSTALL_DIR="$HOME/.local/share/fonts"

# Create the installation directory if it doesn't exist
mkdir -p "$FONT_INSTALL_DIR"

# Check if there are zip files in the directory
zip_files=($FONT_DIR/*.zip)
if [ -e "${zip_files[0]}" ]; then
    echo "Processing zip files..."

    # Loop through all zip files in the directory
    for zip_file in "$FONT_DIR"/*.zip; do
        echo "Processing $zip_file"

        # Create a temporary directory for unzipping
        temp_dir=$(mktemp -d)

        # Unzip the font file into the temporary directory
        unzip -q "$zip_file" -d "$temp_dir"

        # Move the fonts to the installation directory
        mv "$temp_dir"/* "$FONT_INSTALL_DIR"

        # Remove the temporary directory
        rm -rf "$temp_dir"
    done

    # Update the font cache
    fc-cache -fv

    echo "Fonts installation completed."
else
    echo "No zip files found in $FONT_DIR. Exiting..."
    exit 1
fi
