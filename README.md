# Bash Script for Process Monitoring and Disk Checking

This Bash script contains functions that help monitor system processes in real-time and check disk status. Below, you'll find brief descriptions of each function.

## Comparing Float Arguments

The `compare_float_arguments` function compares three float arguments, determining which one is the largest. Based on the result, it takes appropriate actions.

## Disk Checking

The `disk_check_file` function performs a disk status check, verifying if the disk size exceeds a set limit. Disk status information is saved to the `disk.txt` file.

## Real-Time Process Monitoring

The `process_check_top` function monitors system processes using the `top` command and writes the results to the `top.txt` file. It then processes these results, extracting relevant information such as CPU usage. The final output is presented in a human-readable format.

## Usage Instructions

To run the script, simply invoke it in the terminal. Make sure you have the appropriate permissions to execute the script (`chmod +x script_name.sh`).

```bash
./script_name.sh

Requirements
Bash
Unix/Linux

