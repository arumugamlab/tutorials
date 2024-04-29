---
title: "Introduction to Bash for Bioinformatics"
author: "Mani Arumugam"
date: "29/04/2024"
output:
  slidy_presentation:
    number_sections: yes
    duration: 120
    footer: "PIG-PARADIGM Workshop, 29.04.2024. &nbsp;&nbsp; Copyright (c) 2024, Arumugam
      Group. &nbsp;&nbsp;Free for non-commercial use."
  beamer_presentation: default
---

# Overview
- **Objective:** Learn to use the Bash shell for bioinformatics tasks.
- **Agenda:**
  - Introduction to Linux
  - Understanding the Bash Shell
  - Basic Bash Commands
  - Connecting to servers and transferring files

---

# Introduction to Linux
- **What is Linux?**
  - An operating system used widely in scientific computing.
- **Why Linux for Bioinformatics?**
  - Robust, supports numerous bioinformatics tools, strong community.

---

# Understanding the Bash Shell
- **What is Bash?**
  - A command line interface and scripting environment on Linux.
- **Why Bash?**
  - Essential for automating tasks and running bioinformatics software.

---

# Navigating the File System
- **Basic Commands:**
  - `pwd` — Print working directory.
  ```bash
  $ pwd
  /home/ucdavis
  $
  ```
---

# Navigating the File System
- **Basic Commands:**
  - `ls` — List directory contents. 
```bash
$ ls -lh
total 560K
-rw-r--r--. 1 ucdavis users 7.3K Feb 27  2020 adaptors_BGI.fasta
-rw-r--r--. 1 ucdavis users 1.7K Feb 27  2020 adaptors.fasta
-rw-r--r--. 1 ucdavis users  149 Jul 22  2020 adaptors_NovoGene.fasta
-rw-r--r--. 1 ucdavis users  12K Apr 23 11:23 linux-markdown.html
-rw-r--r--. 1 ucdavis users 3.9K Apr 23 11:23 linux-markdown.md
-rw-r--r--. 1 ucdavis users  12K Aug 31  2022 msb-pkgs.txt
-rw-r--r--. 1 ucdavis users 5.7K Mar 20  2023 pubmed2wikipedia.xsl
-rw-r--r--. 1 ucdavis users  179 Mar 17  2023 qhold.sbatch
drwxr-xr-x. 3 ucdavis users   45 Sep 13  2022 R
-rw-r--r--. 1 ucdavis users  591 Nov  1  2022 README.jupyter
$
```
---

# Navigating the File System
- **Basic Commands:**
  - `cd` — Change directory. 
```bash
$ cd /tmp
$ pwd
/tmp
$ 
```
  
- **Tips:** Understand absolute vs. relative paths.

---

# File Management

- **Creating and Editing Files:**
  - In the beginning, there was nothing ...
```bash
$ ls -lh
total 0
```

---

# File Management

- **Creating and Editing Files:**
  - `touch` — Create a new file.
```bash
$ touch example.txt
$ ls -lh
total 0
-rw-r--r--. 1 ucdavis users 0 Apr 23 11:30 example.txt
$ 
```
---

# File Management

- **Copying, Moving, Deleting:**
  - `cp` — Copy files.
```bash
$ cp example.txt backup.txt
$ ls -lh
total 0
-rw-r--r--. 1 ucdavis users 0 Apr 23 11:31 backup.txt
-rw-r--r--. 1 ucdavis users 0 Apr 23 11:30 example.txt
$
```
Note the timestamp for `backup.txt`.

---

# File Management

- **Copying, Moving, Deleting:**
  - `mv` — Move or rename files.
```bash
$ mv example.txt new_name.txt
$ ls -lh
total 0
-rw-r--r--. 1 ucdavis users 0 Apr 23 11:31 backup.txt
-rw-r--r--. 1 ucdavis users 0 Apr 23 11:30 new_name.txt
$
```
Note the timestamp for `new_name.txt`

---

# File Management

- **Copying, Moving, Deleting:**
  - `rm` — Remove files.
```bash
$ rm backup.txt
$ ls -lh
total 0
-rw-r--r--. 1 ucdavis users 0 Apr 23 11:30 new_name.txt
$
```

---

# Viewing and Managing File Content
- **Commands:**
  - `cat` — Display file contents. Example: `cat file.txt`
  - `less`, `more` — Scroll through text. Example: `less file.txt`
  - `head`, `tail` — Show file start/end. Example: `head -n 5 file.txt`
- **Searching in Files:**
  - `grep` — Search for text patterns. Example: `grep "sequence" file.txt`

---

# Useful Commands for File Data Manipulation
- **Sorting, Joining, and Counting:**
  - `sort` — Sort file lines. Example: `sort names.txt`
  - `uniq` — Report or omit repeated lines. Example: `uniq names.txt`
  - `wc` — Print newline, word, and byte counts. Example: `wc file.txt`
- **Extracting Columns and Text Processing:**
  - `cut` — Remove sections from each line of files. Example: `cut -f1,3 -d',' data.csv`
  - `awk` — Pattern scanning and processing language. Example: `awk '{print $1}' file.txt`
  - `sed` — Stream editor for filtering and transforming text. Example: `sed 's/old/new/g' file.txt`

---

# Permissions and Process Management
- **Understanding Permissions:**
  - `chmod` — Modify file permissions. Example: `chmod u+rwx script.sh`
  - `chown` — Change file owner and group. Example: `chown user:group file.txt`
- **Managing Processes:**
  - `top` — Display Linux processes. Example: `top`

---

# Bash Scripting Basics
- **Creating a Bash Script:**
  - Basic script structure and syntax. Example: Script to list files and counts words.
```bash
#!/bin/bash
echo "Listing files..."
ls
echo "Counting words in text file..."
wc -w sample.txt
```
  - You can use bash *variables* for storing text, numbers, etc.

```
$ A=1
$ echo $A
1
$ my_text="hello world!"
$ echo $my_text
hello world!
$
```
---

# Connecting to your dedicated servers for this workshop
- **Find your server's IP address**
  - Visit the spreadsheet [here](https://docs.google.com/spreadsheets/d/1jEyd7VNX-5IKzjZESfbvDgyYigiXteMv3oR2ArB8KW0/edit)
  - Find the IP address for your group
- **Connect to your server**
  - Go to your terminal
  - Connect as follows:
  ```bash
  $ ssh user@192.168.1.1
  ```
  - Enter password
  - Now you are in the remote server

---

# Remote file Management

- **Copying from a server:**
  - `scp` — Secure copy files over SSH.
  - Here is the **syntax** for using `scp` to receive files
```
scp user@server:/location/file local_file
```
  - Here is the **syntax** for using `scp` to send files
```
scp local_file user@server:/location/file
```

- **Copying from a server:**
```bash
$ scp ucdavis@192.168.1.1:/home/ucdavis/tutorial/metaG/assembly.yaml .
$
```

- **Copying to a server:**
```bash
$ scp assembly.yaml ucdavis@192.168.1.1:/home/ucdavis/
$
```
---

# DNA Sequence Data File Formats
## Understanding FASTA and FASTQ Formats
- Essential for handling genomic data in bioinformatics workflows.

---

# Introduction to the FASTA Format
- **What is FASTA?**
  - A text-based format for nucleotide or peptide sequences.
  - Each sequence in a FASTA file begins with a single-line description, followed by lines of sequence data.
- **FASTA Format Structure:**
  - Description line starts with a `>` symbol.
  - Sequence lines follow the description; they can be of varying lengths.
```text
>seq1
ATGCTAGCTAGCTACGATCGATCGATACGATC
AGCTAGCTAGCTGATCGATCGTAGCTAGCTAG
>seq2
GTCAGTCAGATCGATCGTAGCTAGCTACGATC
```

- **Common Uses:**
  - Storing gene sequences, scaffolds, or protein sequences.
  - Frequently used in databases, sequence analysis, and alignment tools.

---

# Introduction to the FASTQ Format
- **What is FASTQ?**
  - A format similar to FASTA but includes sequencing quality scores.
  - Used extensively in high-throughput sequencing (HTS).
- **FASTQ Format Structure:**
  - Each sequence has four lines:
  - A description line starting with `@`.
  - The raw sequence letters.
  - A line starting with `+` (optionally followed by the same sequence identifier and description).
  - The quality score line (ASCII characters representing the quality scores for each nucleotide).
  
```
@seq1
ATGCTAGCTAGCTACGATCGATCGATACGATC
+
!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65
```

- **Quality Scores:**
  - Each character represents a quality score for the corresponding nucleotide, influencing the reliability of each base call.

---

# Q&A
- **Any questions or clarifications?**
