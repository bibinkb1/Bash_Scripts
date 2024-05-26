#!/bin/bash
backup_dir="/tmp"
source_dir="/home/bibin/Work/bash"
backup_filename="backup_$(date +'%Y%m%d').tar.gz"
tar -czvf "$backup_dir/$backup_filename" -C "$source_dir"