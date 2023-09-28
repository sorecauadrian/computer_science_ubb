#include "user_window.h"
#include "ui_user_window.h"

UserWindow::UserWindow(int current_index, Service &service, Repository &repo, QWidget *parent) : QMainWindow(parent), ui(new Ui::UserWindow), repo(repo), service(service), current_index(current_index)
{
    ui ->setupUi(this);
    auto& current_driver = this -> repo.get_drivers()[this -> current_index];
    this ->setWindowTitle(QString::fromStdString(current_driver.get_name()));

    std::string location = std::to_string(current_driver.get_latitude()) + ", " + std::to_string(current_driver.get_longitude());
    this -> ui -> locationLineEdit -> setText(QString::fromStdString(location));
    this -> ui -> locationLineEdit -> setEnabled(false);
    this -> ui -> scoreLineEdit -> setText(QString::number(current_driver.get_score()));
    this -> ui -> scoreLineEdit -> setEnabled(false);
    this -> populateReportsList();

    // add report
    QObject::connect(this -> ui -> addPushButton, &QPushButton::clicked, this, [&]()
    {
        auto description = this -> ui -> descLineEdit -> text().toStdString();
        auto latitude = this -> ui -> latiLineEdit -> text().toInt();
        auto longitude = this -> ui -> longiLineEdit -> text().toInt();
        auto& current_driver = this -> repo.get_drivers()[this -> current_index];
        auto name = current_driver.get_name();
        this -> ui -> descLineEdit -> clear();
        this -> ui -> latiLineEdit -> clear();
        this -> ui -> longiLineEdit -> clear();

        if (description.empty() || ((current_driver.get_latitude() - latitude) * (current_driver.get_latitude() - latitude) + (current_driver.get_longitude() - longitude) * (current_driver.get_longitude() - longitude) > 20 * 20))
        {
            QMessageBox::critical(this, QString("Error"), QString("description is empty or report is too far away."));
            return;
        }
        std::string f = "false";
        this -> service.add(description, name, latitude, longitude, f);
    });

    // validate report
    QObject::connect(this -> ui -> validatePushButton, &QPushButton::clicked, this, [&]()
    {
        const auto& current_text = this -> ui -> reportsListWidget -> selectedItems().at(0)-> text().toStdString();
        std::string current_element;
        std::vector<std::string> elems;
        for (int i = 0, size = current_text.size(); i < size; i++)
        {
            if (current_text[i] == ',')
            {
                elems.emplace_back(current_element);
                current_element = "";
            }
            else if (current_element[i] != ' ')
                current_element += current_text[i];
        }
        elems.emplace_back(current_element);
        auto report = Report(elems[0], elems[1], std::stoi(elems[2]), std::stoi(elems[3]), !(elems.back() == "false"));
        if (this -> validated.count({report.get_longitude(), report.get_latitude()}))
            return;
        this -> validated.emplace(report.get_longitude(), report.get_latitude());
        auto& reporter = elems[1];
        auto& drivers = this -> repo.get_drivers();
        int reporter_id;
        for (int i = 0; ; i++)
        {
            if (drivers[i].get_name() == reporter)
            {
                reporter_id = i;
                break;
            }
        }
        auto& reports = this -> repo.get_reports();
        int report_id;
        for (int i = 0; ; i++)
        {
            if (report.get_latitude() == reports[i].get_latitude() && report.get_longitude() == reports[i].get_longitude())
            {
                report_id = i;
                break;
            }
        }
        this -> service.validate(report_id, reporter_id);
    });

    // send text to chat
    QObject::connect(this -> ui -> sendPushButton, &QPushButton::clicked, this, [&]()
    {
        auto& current_driver = this -> repo.get_drivers()[this -> current_index];
        std::string text = current_driver.get_name() + ": " + this -> ui -> chatLineEdit -> text().toStdString();
        this -> ui -> chatLineEdit -> clear();
        this -> service.send(text);
    });


}

void UserWindow::populateReportsList()
{
    this -> ui -> reportsListWidget -> clear();
    auto& current_driver = this -> repo.get_drivers()[this -> current_index];
    auto& reports = this -> repo.get_reports();
    for (auto& report : reports)
    {
        if (!((current_driver.get_latitude() - report.get_latitude()) * (current_driver.get_latitude() - report.get_latitude()) + (current_driver.get_longitude() - report.get_longitude()) * (current_driver.get_longitude() - report.get_longitude()) <= 10 * 10))
            continue;
        auto str_report = report.get_description() + ", " + report.get_reporter() + ", " + std::to_string(report.get_latitude()) + std::to_string(report.get_longitude()) + ", " + (report.get_status()? "true" : "false");
        auto current_item = new QListWidgetItem(QString::fromStdString(str_report));
        if (report.get_status())
        {
            QFont boldFont;
            boldFont.setBold(true);
            current_item->setFont(boldFont);
            current_item->setFlags(current_item->flags() & ~Qt::ItemIsSelectable);
        }
        if (report.get_reporter() == current_driver.get_name() || this -> validated.count({report.get_longitude(), report.get_latitude()}))
            current_item ->setFlags(current_item->flags() & ~Qt::ItemIsSelectable);
        this -> ui -> reportsListWidget->addItem(current_item);
    }
}

void UserWindow::populateChatList()
{
    this -> ui -> chatListWidget -> clear();
    auto& chat_text = this -> repo.get_chat_text();
    for (auto& line : chat_text)
        this -> ui -> chatListWidget ->addItem(QString::fromStdString(line));
}

void UserWindow::update(int reporter_id)
{
    this -> populateReportsList();
    this -> populateChatList();
    if (reporter_id != -1)
    {
        auto& current_driver = this -> repo.get_drivers()[this -> current_index];
        auto& reporter_driver = this -> repo.get_drivers()[reporter_id];
        if (current_driver.get_name() == reporter_driver.get_name())
            this -> ui -> scoreLineEdit ->setText(QString::number(current_driver.get_score()));
    }
}

UserWindow::~UserWindow()
{
    delete ui;
    this -> repo.save_to_file();
}
