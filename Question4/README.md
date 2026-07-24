## Question 4: Conceptual Explanations

* **Mechanics of Inter-Process Communication (IPC) Using Pipes:**
  A pipe allocates a unidirectional data channel within kernel memory, exposed via a pair of standard file descriptors. Following a `fork()`, both processes inherit these descriptors; by establishing a convention where the parent closes the read end (`pipefd[0]`) and the child closes the write end (`pipefd[1]`), data can safely be streamed across isolated process memory spaces without risking data collisions or synchronization blocks.