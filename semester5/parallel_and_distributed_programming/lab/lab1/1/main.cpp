#include <iostream>
#include <vector>
#include <thread>

#include <ThreadsManager/ThreadsManager.h>

int main(int argc, char** argv)
{
    srand(time(0));

    const int THREADS_NUMBER = 100;
    int threadsNumber = argc > 1 ? atoi(argv[1]) : THREADS_NUMBER;

    Supermarket supermarket("../Files/products.txt");

    std::vector<std::thread> threads;
    threads.reserve(threadsNumber);

    std::chrono::system_clock::time_point startTime = std::chrono::system_clock::now();

    for (size_t i = 0; i < threadsNumber; i++)
        threads.emplace_back(std::thread(ThreadsManager::worker, std::ref(supermarket)));

    for (size_t i = 0; i < threadsNumber; i++)
        threads[i].join();

    ThreadsManager::executeConsistencyCheckWithProbability(supermarket, 1);

    std::chrono::system_clock::time_point endTime = std::chrono::system_clock::now();
    std::cout << "execution time = " << std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime).count() << " microseconds\n";
    return 0;
}
