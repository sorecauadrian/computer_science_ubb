#include "driver.h"

Driver::Driver()
{
    this -> name = "";
    this -> latitude = 0;
    this -> longitude = 0;
    this -> score = 0;
}

Driver::Driver(std::string& name, int latitude, int longitude, int score)
{
    this -> name = name;
    this -> latitude = latitude;
    this -> longitude = longitude;
    this -> score = score;
}

std::string Driver::get_name() const {return this -> name;}

int Driver::get_latitude() const {return this -> latitude;}

int Driver::get_longitude() const {return this -> longitude;}

int Driver::get_score() const {return this -> score;}

void Driver::set_score(int new_score) {this -> score = new_score;}

