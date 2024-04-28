---
title: "Introduction to Bash for Bioinformatics"
author: "Mani Arumugam"
date: "29/04/2024"
output: 
  slidy_presentation: 
    number_sections: true
    duration: 120
    footer: "PIG-PARADIGM Workshop, 29.04.2024. &nbsp;&nbsp; Copyright (c) 2024, Arumugam Group. &nbsp;&nbsp;Free for non-commercial use."
    #font_adjustment: -1
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
  /home/mjq180
  $
  ```
---

# Navigating the File System
- **Basic Commands:**
  - `ls` — List directory contents. 
```bash
$ ls -lh
total 560K
-rw-r--r--. 1 mjq180 users 7.3K Feb 27  2020 adaptors_BGI.fasta
-rw-r--r--. 1 mjq180 users 1.7K Feb 27  2020 adaptors.fasta
-rw-r--r--. 1 mjq180 users  149 Jul 22  2020 adaptors_NovoGene.fasta
-rw-r--r--. 1 mjq180 users  12K Apr 23 11:23 linux-markdown.html
-rw-r--r--. 1 mjq180 users 3.9K Apr 23 11:23 linux-markdown.md
-rw-r--r--. 1 mjq180 users  12K Aug 31  2022 msb-pkgs.txt
-rw-r--r--. 1 mjq180 users 5.7K Mar 20  2023 pubmed2wikipedia.xsl
-rw-r--r--. 1 mjq180 users  179 Mar 17  2023 qhold.sbatch
drwxr-xr-x. 3 mjq180 users   45 Sep 13  2022 R
-rw-r--r--. 1 mjq180 users  591 Nov  1  2022 README.jupyter
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
-rw-r--r--. 1 mjq180 users 0 Apr 23 11:30 example.txt
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
-rw-r--r--. 1 mjq180 users 0 Apr 23 11:31 backup.txt
-rw-r--r--. 1 mjq180 users 0 Apr 23 11:30 example.txt
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
-rw-r--r--. 1 mjq180 users 0 Apr 23 11:31 backup.txt
-rw-r--r--. 1 mjq180 users 0 Apr 23 11:30 new_name.txt
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
-rw-r--r--. 1 mjq180 users 0 Apr 23 11:30 new_name.txt
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
  - Visit the spreadsheet [here]()
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

- **Copying from and to a server:**
  - `scp` — Secure copy files over SSH.
```bash
$ scp example.txt user@server.com:/home/user/
$ scp user@server.com:/home/user/example.txt .
$
```
---


# Q&A
- **Any questions or clarifications?**
