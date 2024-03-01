#include <QApplication>
#include "repository.h"
#include "service.h"
#include "user_window.h"

int main(int argc, char** argv)
{
    QApplication a(argc, argv);
    Repository repo("../drivers.txt", "../reports.txt");
    Service service(repo);

    int nr_drivers = repo.get_drivers().size();
    std::vector<std::shared_ptr<UserWindow>> windows;
    for (int i = 0; i < nr_drivers; i++)
    {
        std::shared_ptr<UserWindow> window = std::make_shared<UserWindow>(i, service, repo);
        service.add_observer(window);
        window->show();
        windows.emplace_back(window);
    }
    return QApplication::exec();
}
