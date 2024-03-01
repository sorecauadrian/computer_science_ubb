cmake_minimum_required(VERSION 3.25)
project(drivers)

set(CMAKE_PREFIX_PATH "/home/sorecauadrian/Qt/6.5.0/")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)



find_package(Qt6 COMPONENTS Core Gui Widgets REQUIRED)
qt6_add_resources(Qt6 COMPONENTS qml.qrc)
add_executable(drivers main.cpp driver.h driver.cpp report.h report.cpp repository.h repository.cpp subject.h subject.cpp observer.h service.h service.cpp user_window.h user_window.cpp ui_user_window.h)
target_link_libraries(drivers Qt6::Core Qt6::Gui Qt6::Widgets)
