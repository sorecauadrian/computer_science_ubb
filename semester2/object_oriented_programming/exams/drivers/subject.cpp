#include "subject.h"

void Subject::add_observer(std::shared_ptr<Observer> obs) {this -> observers.emplace_back(obs);}

void Subject::notify(int reporter_id)
{
    for (auto& obs : this -> observers)
        obs->update(reporter_id);
}


