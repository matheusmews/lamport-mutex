# Compilador e flags
CXX = g++
CXXFLAGS = -Wall -fPIC -std=c++17

# Biblioteca
LIB_NAME = libmutex.so
LIB_SRC = libmutex.cpp
LIB_HDR = libmutex.h

# Programas principais
LAMPORT_SRC = main_lamport.cpp
PTHREAD_SRC = main_pthread.cpp
LAMPORT_OUT = run_lamport.out
PTHREAD_OUT = run_pthread.out

# Linkagem para biblioteca
LDFLAGS_LAMPORT = -L. -lmutex -lpthread
LDFLAGS_PTHREAD = -lpthread

# Alvo padrão: compila tudo
all: $(LIB_NAME) $(LAMPORT_OUT) $(PTHREAD_OUT)

# Compilar a biblioteca
$(LIB_NAME): $(LIB_SRC) $(LIB_HDR)
	$(CXX) $(CXXFLAGS) -shared -o $(LIB_NAME) $(LIB_SRC)

# Compilar programa que usa a biblioteca com Algoritmo de lamport
$(LAMPORT_OUT): $(LAMPORT_SRC) $(LIB_NAME)
	$(CXX) $(CXXFLAGS) $(LAMPORT_SRC) -o $(LAMPORT_OUT) $(LDFLAGS_LAMPORT)

# Compilar programa com pthread_mutex
$(PTHREAD_OUT): $(PTHREAD_SRC)
	$(CXX) $(CXXFLAGS) $(PTHREAD_SRC) -o $(PTHREAD_OUT) $(LDFLAGS_PTHREAD)

# Executar a versão com Lamport
run_lamport: $(LAMPORT_OUT)
	LD_LIBRARY_PATH=. ./$(LAMPORT_OUT)

# Executar a versão com pthread_mutex
run_pthread: $(PTHREAD_OUT)
	./$(PTHREAD_OUT)

# Limpeza
clean:
	rm -f $(LIB_NAME) $(LAMPORT_OUT) $(PTHREAD_OUT)
