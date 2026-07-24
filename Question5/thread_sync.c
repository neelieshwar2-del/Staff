#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

// Global shared resource and mutex lock
pthread_mutex_t lock;
int shared_counter = 0;

// Worker function executed by each thread
void* perform_work(void* arg) {
    long thread_id = (long)arg;
    
    // Acquire the lock before entering the critical section
    pthread_mutex_lock(&lock);
    
    printf("Thread %ld acquired lock. Current Counter: %d\n", thread_id, shared_counter);
    shared_counter++; // Modifying shared memory safely
    printf("Thread %ld updated Counter to: %d. Releasing lock.\n", thread_id, shared_counter);
    
    // Release the lock after finishing work
    pthread_mutex_unlock(&lock);
    
    return NULL;
}

int main() {
    pthread_t threads[3];
    
    // Initialize the mutex
    if (pthread_mutex_init(&lock, NULL) != 0) {
        printf("Mutex initialization failed!\n");
        return 1;
    }

    printf("Starting Thread Synchronization Demo...\n");

    // Create 3 worker threads
    for (long i = 0; i < 3; i++) {
        if (pthread_create(&threads[i], NULL, perform_work, (void*)i) != 0) {
            perror("Failed to create thread");
            return 1;
        }
    }

    // Wait for all threads to complete execution
    for (int i = 0; i < 3; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("All threads executed safely. Final Counter: %d\n", shared_counter);

    // Destroy mutex resource
    pthread_mutex_destroy(&lock);
    return 0;
}