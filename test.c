#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
void* threadfunc(void* ignored) {
	while (1) {
		pause();
	}
	return NULL;
}
int main() {
	pthread_t thread;
	pthread_create(&thread, NULL, &threadfunc, NULL);
	sleep(1);
	pthread_cancel(thread);
	printf("OK, alive\n");
}

