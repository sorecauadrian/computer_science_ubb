#ifndef DRIVERS_SERVICE_H
#define DRIVERS_SERVICE_H

#include "repository.h"
#include "subject.h"

class Service : public Subject
{
    private:
        Repository& repo;
    public:
        Service(Repository& repo);
        void add(std::string&, std::string&, int, int, std::string&);
        void validate(int, int);
        void send(std::string&);
};

#endif //DRIVERS_SERVICE_H
