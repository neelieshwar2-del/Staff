## Question 5: Conceptual Explanations

* **Thread Synchronization and Mutex Locks:**
  When multiple threads execute concurrently within the same memory address space, race conditions can occur if they access shared resources simultaneously. Utilizing a POSIX Mutex (`pthread_mutex_lock` / `pthread_mutex_unlock`) enforces mutual exclusion, ensuring that only one thread can modify critical-section variables at any given time.