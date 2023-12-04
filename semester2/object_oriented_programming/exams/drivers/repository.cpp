#include "repository.h"

Repository::Repository()
{
    this -> drivers_filename = "";
    this -> reports_filename = "";
}

Repository::Repository(const std::string& drivers_filename, const std::string& reports_filename)
{
    this -> drivers_filename = drivers_filename;
    this -> reports_filename = reports_filename;
    this ->read_from_file();
}

void Repository::read_from_file()
{
    // read drivers
    std::ifstream fin(this -> drivers_filename);
    int nr_drivers;
    fin >> nr_drivers;
    while (nr_drivers--)
    {
        std::string name;
        int latitude, longitude, score;
        fin >> name >> latitude >> longitude >> score;
        this -> drivers.emplace_back(name, latitude, longitude, score);
    }
    fin.close();

    // read reports
    fin.open(this -> reports_filename);
    int nr_reports;
    fin >> nr_reports;
    while (nr_reports--)
    {
        std::string description, reporter, valid_status;
        int latitude, longitude;
        fin >> description >> reporter >> latitude >> longitude >> valid_status;
        this -> reports.emplace_back(description, reporter, latitude, longitude, (valid_status == "false"? 0 : 1));
    }
    fin.close();
}

void Repository::save_to_file()
{
    std::ofstream fout(this -> reports_filename);
    fout << this -> reports.size() << "\n\n";
    for (auto& report : this -> reports)
    {
        fout << report.get_description() << "\n";
        fout << report.get_reporter() << "\n";
        fout << report.get_latitude() << " " << report.get_longitude() << "\n";
        fout << (!report.get_status() ? "false" : "true") << "\n\n";
    }
    fout.close();
}

void Repository::add_report(std::string &description, std::string &reporter, int latitude, int longitude, std::string &valid_status)
{
    Report report(description, reporter, latitude, longitude, valid_status == "true");
    this -> reports.emplace_back(report);
}

void Repository::add_chat_text(const std::string &text) {this -> chat_text.emplace_back(text);}

std::vector<std::string> &Repository::get_chat_text() {return this -> chat_text;}

std::vector<Driver> &Repository::get_drivers() {return this -> drivers;}

std::vector<Report> &Repository::get_reports() {return this -> reports;}

