#ifndef DRIVERS_OBSERVER_H
#define DRIVERS_OBSERVER_H

class Observer
{
    public:
        virtual void update(int reporter_id) = 0;
        virtual ~Observer() = default;
};

#endif //DRIVERS_OBSERVER_H
