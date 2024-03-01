#ifndef DRIVERS_REPORT_H
#define DRIVERS_REPORT_H

#include <string>

class Report
{
    private:
        std::string description;
        std::string reporter;
        int latitude;
        int longitude;
        bool valid_status;
        int nr_validators;
    public:
        Report();
        Report(std::string&, std::string&, int, int, bool);
        std::string get_description() const;
        std::string get_reporter() const;
        int get_latitude() const;
        int get_longitude() const;
        bool get_status() const;
        void set_status();
        int get_nr_validators() const;
        void set_nr_validators(int);
};

#endif //DRIVERS_REPORT_H
