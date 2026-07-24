## Question 1: Conceptual Explanations

* **Justification of Linux Commands Used:** 
  The script utilizes `md5sum` within a loop to look at the actual contents of the files, which ensures accurate duplicate detection even if files have different names.
   
* **Justification of Redirection Operators & File-Handling:** 
  The `>>` operator safely appends execution metrics to `system_report.txt` without destroying previous data, while `2>>` redirects the standard error stream to `error_log.txt` to isolate error logs from the main summary report.