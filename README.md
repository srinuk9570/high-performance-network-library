# High-Performance Network Library

A lightweight, high-performance TCP networking library built in **C++17** for Linux systems programming and concurrent client-server applications.

The project focuses on understanding and implementing low-level networking concepts such as **Linux ****`epoll`****, non-blocking sockets, event-driven I/O, TCP/IP communication, connection management, buffering, and multithreaded request handling**.

> **Developer:** Katravath Srinu
> **B.Tech CSE, IIT (BHU) Varanasi**
> **GitHub:** https://github.com/srinuk9570
> **LinkedIn:** https://www.linkedin.com/in/katravathsrinu/

---

## Features

* C++17-based networking library
* Linux/POSIX socket programming
* TCP client-server communication
* Non-blocking socket operations
* Linux `epoll` for I/O multiplexing
* Edge-triggered event handling
* Reactor-style event loop
* Multithreaded connection handling
* Thread-pool based workload distribution
* Socket and connection abstractions
* Read/write buffering
* Connection lifecycle management
* Asynchronous event processing
* CMake-based build system
* Unit testing
* Performance benchmarking

---

## Architecture

The networking stack is organized around a small set of reusable components:

```text
                         Client Connections
                                |
                                v
                        +---------------+
                        |    Acceptor   |
                        +-------+-------+
                                |
                                v
                        +---------------+
                        |  Event Loop   |
                        |   (Reactor)  |
                        +-------+-------+
                                |
                                v
                        +---------------+
                        |    epoll      |
                        +-------+-------+
                                |
                +---------------+---------------+
                |                               |
                v                               v
        +---------------+               +---------------+
        |   Connection  |               |   Connection  |
        +-------+-------+               +-------+-------+
                |                               |
                v                               v
        +---------------+               +---------------+
        | Read/Write    |               | Read/Write    |
        |    Buffer     |               |    Buffer     |
        +---------------+               +---------------+

                    Thread Pool
                         |
          +--------------+--------------+
          |              |              |
       Worker 1       Worker 2       Worker N
```

### Core Components

| Component       | Responsibility                                    |
| --------------- | ------------------------------------------------- |
| **Socket**      | Creates and manages Linux socket file descriptors |
| **Connection**  | Represents an active TCP client connection        |
| **Buffer**      | Handles incoming and outgoing data                |
| **Acceptor**    | Accepts new client connections                    |
| **Poller**      | Manages `epoll` events                            |
| **Event Loop**  | Processes ready I/O events                        |
| **Thread Pool** | Distributes connection/event processing           |
| **Server**      | Provides the high-level server interface          |

---

## Networking Model

The library uses an event-driven architecture based on Linux `epoll`.

```text
                    Server Socket
                          |
                          v
                       accept()
                          |
                          v
                    Client Socket
                          |
                          v
                 Non-Blocking I/O
                          |
                          v
                       epoll
                          |
              +-----------+-----------+
              |                       |
           EPOLLIN                 EPOLLOUT
              |                       |
              v                       v
         Read Data               Write Data
              |                       |
              +-----------+-----------+
                          |
                          v
                    Event Handler
```

This approach avoids blocking a worker thread on individual socket operations and allows the server to manage many concurrent connections efficiently.

---

## Technology Stack

* **Language:** C++17
* **Operating System:** Linux
* **Networking:** TCP/IP, POSIX Sockets
* **I/O Multiplexing:** Linux `epoll`
* **Concurrency:** C++ Threads / Thread Pool
* **Build System:** CMake
* **Testing:** CTest
* **Version Control:** Git / GitHub

---

## Project Structure

```text
High-Performance-Network-Library/
│
├── src/
│   ├── core/
│   ├── network/
│   ├── server/
│   └── ...
│
├── include/
│   └── ...
│
├── test/
│   └── ...
│
├── demo/
│   └── ...
│
├── CMakeLists.txt
├── README.md
└── LICENSE
```

> The exact directory structure may change as the project develops.

---

# Build and Run

## Requirements

* Linux / WSL2
* GCC 11+ or Clang 14+
* CMake 3.20+
* Git

## Complete Terminal Flow

Run the following commands from the VS Code terminal:

```bash
# 1. Clone the repository
git clone <YOUR-GITHUB-REPOSITORY-URL>

# 2. Enter the project
cd High-Performance-Network-Library

# 3. Create build directory
mkdir -p build
cd build

# 4. Configure the project
cmake ..

# 5. Build
cmake --build . -j$(nproc)

# 6. Run tests
ctest --output-on-failure

# 7. Return to project root
cd ..

# 8. Run the demo/server
./build/<SERVER_EXECUTABLE>

# 9. In another terminal, run the client/demo
./build/<CLIENT_EXECUTABLE>
```

> Replace `<YOUR-GITHUB-REPOSITORY-URL>`, `<SERVER_EXECUTABLE>`, and `<CLIENT_EXECUTABLE>` with the actual values used by the project.

---

## Example TCP Server Flow

The intended server workflow is:

```text
Create Socket
     |
     v
Bind Address
     |
     v
Listen
     |
     v
Accept Client
     |
     v
Set Non-Blocking Mode
     |
     v
Register FD with epoll
     |
     v
Wait for Events
     |
     v
Read / Write Data
     |
     v
Handle Connection
```

---

## Example Client/Server Communication

```text
+----------+                         +----------+
|  Client  |                         |  Server  |
+----+-----+                         +----+-----+
     |                                    |
     | -------- TCP Connect ------------> |
     |                                    |
     | ----------- Request ------------> |
     |                                    |
     | <---------- Response ------------ |
     |                                    |
     | ----------- Request ------------> |
     |                                    |
     | <---------- Response ------------ |
     |                                    |
```

---

# Performance Testing

Performance testing is an important part of this project.

The goal is to evaluate:

* Concurrent connections
* Requests per second
* Event-loop overhead
* Socket I/O performance
* Thread-pool behavior
* Connection handling
* CPU utilization
* Memory usage
* Latency under concurrent workloads

Example benchmark flow:

```bash
cd build

# Build benchmark
cmake --build . --target benchmark -j$(nproc)

# Run benchmark
./benchmark
```

**Important:** benchmark numbers will be added only after running reproducible tests on the actual implementation and documenting the hardware/software environment.

---

# Testing

The project uses automated tests to verify core networking components.

```bash
cd build

ctest --output-on-failure
```

Testing areas include:

* Socket creation
* Address handling
* Connection management
* Buffer operations
* Event handling
* Server/client communication

---

# Design Goals

The project is being developed with the following goals:

### 1. Low-Level Networking

Understand Linux networking at the socket and file-descriptor level.

### 2. High Concurrency

Use non-blocking I/O and `epoll` to efficiently manage multiple connections.

### 3. Modular Architecture

Keep networking components separated so they can be reused and tested independently.

### 4. Performance

Reduce unnecessary blocking, system overhead, memory allocations, and synchronization costs where appropriate.

### 5. Reliability

Use automated tests and reproducible benchmarks to validate behavior and performance.

---

# Learning Focus

This project provides practical experience with:

* C++17
* Linux systems programming
* POSIX APIs
* TCP/IP networking
* Socket programming
* `epoll`
* Non-blocking I/O
* Event-driven architecture
* Reactor pattern
* Multithreading
* Thread pools
* Memory management
* CMake
* Unit testing
* Performance engineering
* Debugging concurrent systems

---

# Roadmap

* [x] TCP socket abstraction
* [x] Non-blocking socket support
* [x] Linux `epoll` integration
* [x] Event-driven architecture
* [x] Connection management
* [x] CMake build system
* [x] Basic testing infrastructure
* [ ] Improve error handling
* [ ] Add more networking tests
* [ ] Add benchmark automation
* [ ] Improve connection scalability
* [ ] Add UDP support
* [ ] Add zero-copy optimizations where appropriate
* [ ] Add detailed latency measurements
* [ ] Add profiling and performance analysis
* [ ] Improve documentation

---

# Development

Format and build the project using:

```bash
# Configure
cmake -S . -B build

# Build
cmake --build build -j$(nproc)

# Test
cd build
ctest --output-on-failure
cd ..
```

---

# Author

**Katravath Srinu**

B.Tech Computer Science and Engineering
IIT (BHU) Varanasi

* GitHub: https://github.com/srinuk9570
* LinkedIn: https://www.linkedin.com/in/katravathsrinu/

---

# License

This project is licensed under the MIT License.

---

## Note on Project Development

This project is developed as a systems-programming and networking portfolio project. Architectural concepts are studied from established open-source networking projects and networking literature.

Any third-party code, libraries, or directly derived implementations should retain their original licenses and attribution.
