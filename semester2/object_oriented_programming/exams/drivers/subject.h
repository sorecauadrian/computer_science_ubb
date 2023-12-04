#ifndef DRIVERS_SUBJECT_H
#define DRIVERS_SUBJECT_H

#include <vector>
#include "observer.h"
#include <memory>

class Subject
{
    private:
        std::vector<std::shared_ptr<Observer>> observers;
    public:
        void add_observer(std::shared_ptr<Observer>);
        void notify(int);
};

#endif //DRIVERS_SUBJECT_H
