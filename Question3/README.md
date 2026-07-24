## Question 3: Conceptual Explanations

* **How low-level system calls contribute to the solution:**
  Using POSIX system calls like `open()`, `read()`, and `write()` interacts directly with the kernel, bypassing standard library buffering for enhanced data security. By utilizing `lseek()`, the utility modifies the file descriptor's read/write offset instantaneously, allowing direct, random-access record modification at specific byte positions without iterating through or rewriting the rest of the file.