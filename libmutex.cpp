#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <ctype.h>

#include "libmutex.h"

using namespace std;

#define MAX_NUM_THREADS 10
bool choosing [MAX_NUM_THREADS];
int ticket [MAX_NUM_THREADS];

int num_threads;

int max_ticket() {
    int max = ticket[0];
    for (int i = 1; i < num_threads; i++){
        max = ticket[i] > max ? ticket[i] : max;
    }
    return max;
}

void lamport_mutex_init(int n_thrds) {
    num_threads = n_thrds;
    for (int j = 0; j < num_threads; j++) {
        choosing[j] = false;
        ticket[j] = 0;
    }
}

void lamport_mutex_lock(int i) {
    choosing[i] = true;
    ticket[i] = max_ticket () + 1;
    choosing[i] = false;
    for (int j = 0; j < num_threads; j++) {
        if(j == i) continue;
        while (choosing[j]) /* nao fazer nada */;
        while (ticket[j] != 0 && (
               (ticket[j] < ticket[i]) || (ticket[j] == ticket[i] && j < i)
        )) /* nao fazer nada */;
    }
}

void lamport_mutex_unlock(int i) {
    ticket[i] = 0; /* indicar que saimos da secao critica */
}
