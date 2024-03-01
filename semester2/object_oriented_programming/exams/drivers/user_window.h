#ifndef DRIVERS_USER_WINDOW_H
#define DRIVERS_USER_WINDOW_H

#include "observer.h"
#include "service.h"
#include "repository.h"
#include <QMainWindow>
#include <set>
#include <QMessageBox>

QT_BEGIN_NAMESPACE
namespace Ui {class UserWindow;}
QT_END_NAMESPACE

class UserWindow : public Observer, public QMainWindow
{

    public:
        UserWindow(int, Service&, Repository&, QWidget* parent = nullptr);
        ~UserWindow() override;
        void update(int reporter_id) override;
    private:
        Ui::UserWindow* ui;
        Repository& repo;
        Service& service;
        int current_index;
        std::set<std::pair<int, int>> validated;
        void populateReportsList();
        void populateChatList();
};

#endif //DRIVERS_USER_WINDOW_H
