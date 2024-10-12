#!/usr/bin/env bash

input_file="ncbi_monkeypox-tx.fasta"
output_file="reverse_complements.fasta"
header=""
sequence=""
echo "What type of sequence do you have, DNA or RNA? "
read sequence_type

# Read the file line by line
while read -r line; do
    # Check if the line is a header
    if [[ "${line:0:1}" == ">" ]]; then
        # If the header is found and if followed by sequence, process the sequence
        if [[ -n "${sequence}" ]]; then
            # Reverse complement the stored sequence
            reverse=$(echo "${sequence}" | rev)
            if [[ "${sequence_type}" == "DNA" ]]; then
                complement=$(echo "$reverse" | tr "ACGT" "TGCA")
            elif [[ "${sequence_type}" == "RNA" ]]; then
                complement=$(echo "$reverse" | tr "ACGU" "UGCA")
            else
                echo "Invalid sequence type. Please enter DNA or RNA."
                exit 1
            fi
            # Write the previous header and its reverse complement to the output file
            echo "${header}" >> "${output_file}"
            echo "${complement}" >>  "${output_file}"
        fi
        # Update the header and reset the sequence
        header="${line}"
        sequence=""
    else
        sequence="${sequence}${line}"
    fi
done < "${input_file}"

# Process the last sequence after the loop ends
if [[ -n "${sequence}" ]]; then
    # Reverse complement the stored sequence
    reverse=$(echo "${sequence}" | rev)

    if [[ "${sequence_type}" == "DNA" ]]; then
        complement=$(echo "$reverse" | tr "ACGT" "TGCA")
    elif [[ "${sequence_type}" == "RNA" ]]; then
        complement=$(echo "$reverse" | tr "ACGU" "UGCA")
    else
        echo "Invalid sequence type. Please enter DNA or RNA."
        exit 1
    fi
    # Write the last header and its reverse complement to the output file
    echo "${header}" >> "${output_file}"
    echo "${complement}" >> "${output_file}"
fi
