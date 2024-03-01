#ifndef DRIVERS_DRIVER_H
#define DRIVERS_DRIVER_H

#include <string>

class Driver
{
    private:
        std::string name;
        int latitude;
        int longitude;
        int score;
    public:
        Driver();
        Driver(std::string&, int, int, int);
        std::string get_name() const;
        int get_latitude() const;
        int get_longitude() const;
        int get_score() const;
        void set_score(int);
};

#endif //DRIVERS_DRIVER_H
