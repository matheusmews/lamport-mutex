#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <ctype.h>

#include "libmutex.h"

using namespace std;

/* Variaveis compartilhadas */
#define N 3

bool choosing [N];
int ticket [N];

int max_ticket() {
    int max = ticket[0];
    for (int i = 1; i < N; i++)
        max = ticket[i] > max ? ticket[i] : max;
    return max;
}

void lamport_mutex_init() {
    for (int j = 0; j < N; j++) {
        choosing[j] = false;
        ticket[j] = 0;
    }
}

void lamport_mutex_lock(int i) {
    choosing[i] = true;
    ticket[i] = max_ticket () + 1;
    choosing[i] = false;
    for (int j = 0; j < N; j++) {
        while (choosing[j]) /* nao fazer nada */;
        while (ticket[j] != 0 && (
                    (ticket[j] < ticket[i]) || (ticket[j] == ticket[i] && j < i)
        )) /* nao fazer nada */;
    }
}

void lamport_mutex_unlock(int i) {
    ticket[i] = 0; /* indicar que saimos da secao critica */
}
