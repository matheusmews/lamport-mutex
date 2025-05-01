# Lamport Mutex - Software-based Mutual Exclusion

This project implements **mutual exclusion in software** using the **Bakery Algorithm** (Lamport, 1974). It also provides a comparative implementation using POSIX `pthread_mutex_t`.

The goal is to:
- Create a dynamically linked library that implements Lamport's Bakery Algorithm.
- Use it to synchronize concurrent access to a shared variable in a multi-threaded environment.
- Compare its correctness and performance with the native `pthread_mutex`.

This project was developed for the **Operating Systems II (INF01151)** course at UFRGS.

---

**Building**

To compile everything:

```bash
make
```

This will generate:
- libmutex.so → shared library
- run_lamport.out → program using Lamport's mutex
- run_pthread.out → program using pthread_mutex

---

**Running**

Run the Lamport version:
```bash
make run_lamport
```
Run the pthread version:
```bash
make run_pthread
```
Run the automated tests to compare both verions:
```bash
make test.csv
```

---

**Cleaning Up**

To remove generated binaries:

```bash
make clean
```

---

👥 Authors:
- Matheus Mews
- Arthur Tonial

