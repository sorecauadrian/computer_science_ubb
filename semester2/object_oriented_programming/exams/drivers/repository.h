#ifndef DRIVERS_REPOSITORY_H
#define DRIVERS_REPOSITORY_H

#include "driver.h"
#include "report.h"
#include <vector>
#include <fstream>

class Repository
{
    private:
        std::string drivers_filename;
        std::string reports_filename;
        std::vector<Driver> drivers;
        std::vector<Report> reports;
        std::vector<std::string> chat_text;
    public:
        Repository();
        Repository(const std::string&, const std::string&);
        void read_from_file();
        void save_to_file();
        void add_report(std::string&, std::string&, int, int, std::string&);
        void add_chat_text(const std::string&);
        std::vector<std::string>& get_chat_text();
        std::vector<Driver>& get_drivers();
        std::vector<Report>& get_reports();
};

#endif //DRIVERS_REPOSITORY_H
