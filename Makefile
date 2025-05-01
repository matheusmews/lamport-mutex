# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -fPIC -std=c++17

# Shared library
LIB_NAME = libmutex.so
LIB_SRC = libmutex.cpp
LIB_HDR = libmutex.h

# Main programs
LAMPORT_SRC = main_lamport.cpp
PTHREAD_SRC = main_pthread.cpp
LAMPORT_OUT = run_lamport.out
PTHREAD_OUT = run_pthread.out

# Linking flags
LDFLAGS_LAMPORT = -L. -lmutex -lpthread
LDFLAGS_PTHREAD = -lpthread

# Build everything
# Usage: make
all: $(LIB_NAME) $(LAMPORT_OUT) $(PTHREAD_OUT)

# Build the shared library
$(LIB_NAME): $(LIB_SRC) $(LIB_HDR)
	$(CXX) $(CXXFLAGS) -shared -o $(LIB_NAME) $(LIB_SRC)

# Build program using Lamport's Bakery Algorithm
$(LAMPORT_OUT): $(LAMPORT_SRC) $(LIB_NAME)
	$(CXX) $(CXXFLAGS) $(LAMPORT_SRC) -o $(LAMPORT_OUT) $(LDFLAGS_LAMPORT)

# Build program using pthread_mutex
$(PTHREAD_OUT): $(PTHREAD_SRC)
	$(CXX) $(CXXFLAGS) $(PTHREAD_SRC) -o $(PTHREAD_OUT) $(LDFLAGS_PTHREAD)

# Run Lamport version
# Usage: make run_lamport "3000000 3"
run_lamport: $(LAMPORT_OUT)
	LD_LIBRARY_PATH=. ./$(LAMPORT_OUT) $(ARGS)

# Run pthread version
# Usage: make run_pthread "3000000 3"
run_pthread: $(PTHREAD_OUT)
	./$(PTHREAD_OUT) $(ARGS)

# Clean all generated files
clean:
	rm -f $(LIB_NAME) $(LAMPORT_OUT) $(PTHREAD_OUT)

# Run automated tests
test_csv: all
	./run_tests.sh
