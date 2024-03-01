#include "service.h"

Service::Service(Repository &repo): repo{repo} {}

void Service::add(std::string &description, std::string &reporter, int latitude, int longitude, std::string &valid_status)
{
    this -> repo.add_report(description, reporter, latitude, longitude, valid_status);
    this -> notify(-1);
}

void Service::validate(int report_id, int reporter_id)
{
    auto& reports = this -> repo.get_reports();
    reports[report_id].set_nr_validators(reports[report_id].get_nr_validators() + 1);
    if (reports[report_id].get_nr_validators() == 2)
    {
        reports[report_id].set_status();
        auto& drivers = this -> repo.get_drivers();
        drivers[reporter_id].set_score(drivers[reporter_id].get_score() + 1);
    }
    this -> notify(reporter_id);
}

void Service::send(std::string &new_text)
{
    this -> repo.add_chat_text(new_text);
    this -> notify(-1);
}


