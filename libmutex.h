#ifndef LIBMUTEX_H
#define LIBMUTEX_H

void lamport_mutex_init(int n_thrds);
void lamport_mutex_lock(int i);
void lamport_mutex_unlock(int i);

#endif // LIBMUTEX_H