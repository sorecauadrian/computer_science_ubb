#include "report.h"

Report::Report()
{
    this -> description = "";
    this -> reporter = "";
    this -> latitude = 0;
    this -> longitude = 0;
    this -> valid_status = false;
    this -> nr_validators = 0;
}

Report::Report(std::string& description, std::string& reporter, int latitude, int longitude, bool valid_status)
{
    this -> description = description;
    this -> reporter = reporter;
    this -> latitude = latitude;
    this -> longitude = longitude;
    this -> valid_status = valid_status;
    this -> nr_validators = 0;
}

std::string Report::get_description() const {return this -> description;}

std::string Report::get_reporter() const {return this -> reporter;}

int Report::get_latitude() const {return this -> latitude;}

int Report::get_longitude() const {return this -> longitude;}

bool Report::get_status() const {return this -> valid_status;}

void Report::set_status() {this -> valid_status = true;}

int Report::get_nr_validators() const {return this -> nr_validators;}

void Report::set_nr_validators(int new_val) {this -> nr_validators = new_val;}
