# Nginx Log Analyser

This is a simple Bash script project for practicing log analysis and Linux command-line skills.
It processes an Nginx access log and summarizes the following information:

* Top 5 IP addresses with the most requests
* Top 5 most requested paths
* Top 5 response status codes
* Top 5 user agents

---

## Overview

This project explores the use of fundamental Linux text-processing tools, including:

* `awk` – pattern scanning, text extraction, and formatting
* `sort` / `uniq` – counting and sorting
* `head` – limiting output
* `sed` / `grep` – optional text matching alternatives

The primary version uses `awk` for most parsing tasks because it combines readability and flexibility.
An optional variant using `grep` and `sed` is also possible for the stretch goal.

---

## Project Structure

```
my_tools/
└── nginx_log_analyser/
    ├── nginx_log_analyser.sh   # main script
    ├── nginx-access.log        # sample log file
    ├── progress.log            # development notes
    └── README.md               # this file
```

---

## Usage

### 1. Enter the project directory

```bash
cd ~/my_tools/nginx_log_analyser
```

### 2. Make the script executable

```bash
chmod +x nginx_log_analyser.sh
```

### 3. Run the analyser

```bash
./nginx_log_analyser.sh nginx-access.log
```

### 4. Example Output

```
========== NGINX LOG REPORT ==========

Top 5 IP addresses with the most requests:
45.76.135.253      - 1000 requests
142.93.143.8       - 600 requests
178.128.94.113     - 50 requests
43.224.43.187      - 30 requests
178.128.94.113     - 20 requests

Top 5 most requested paths:
/api/v1/users      - 1000 requests
/api/v1/products   - 600 requests
/api/v1/orders     - 50 requests
/api/v1/payments   - 30 requests
/api/v1/reviews    - 20 requests

Top 5 response status codes:
200 - 1000 requests
404 - 600 requests
500 - 50 requests
401 - 30 requests
304 - 20 requests

Top 5 user agents:
digitalocean.com   - 4347 requests
Windows            - 814 requests
Macintosh;         - 627 requests
X11;               - 287 requests
Windows            - 156 requests
```

---

## Implementation Notes

* Each section uses `awk` to extract relevant fields, then pipes through
  `sort | uniq -c | sort -rn | head -5` to compute frequencies.
* `printf` ensures clean, aligned output (`%-25s %5s requests`).
* Regular expressions handle request paths, status codes, and user-agent strings.
* The script uses purely POSIX-compatible syntax for portability.
* A separate `grep` / `sed` version can be implemented to meet the optional requirement.

---

## Alternative Implementation (grep/sed version)

To demonstrate equivalent text extraction without using `awk`,
a `grep`/`sed` version can achieve the same results.

Example snippet for "Top 5 IP addresses":

```bash
cut -d' ' -f1 "$file" \
  | sort | uniq -c | sort -rn | head -5 \
  | sed -E 's/^[[:space:]]*([0-9]+)[[:space:]]+(.+)$/\2 - \1 requests/'
```

This approach trades off simplicity for compatibility, helping reinforce understanding of shell pipelines and regex parsing.

---

## Current Status

| Task                                      | Status   |
| ----------------------------------------- | -------- |
| Repository initialized                    | Done     |
| Basic `awk` and `sort` logic implemented  | Done     |
| Output formatting and alignment           | Done     |
| Alternative `grep` / `sed` implementation | Optional |

---

## Learning Summary

Key lessons learned through this project:

* Understanding Nginx access log structure (`IP Date Method Path Status Size UA`)
* Building data-processing pipelines using standard Unix tools
* Using `awk` for both pattern matching and formatted printing
* Differentiating between `print` and `printf` behavior in `awk`
* Dynamically controlling column width for aligned CLI output
* Applying `grep` / `sed` as lightweight parsing alternatives

---

## License

This project is free for personal and educational use.

https://roadmap.sh/projects/nginx-log-analyser