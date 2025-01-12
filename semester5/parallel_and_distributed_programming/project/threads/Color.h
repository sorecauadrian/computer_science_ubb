#ifndef COLOR_H
#define COLOR_H

#include <map>
#include <string>
#include <vector>

class Color {
public:
    Color(int n);
    std::map<int, std::string> getColors() const;
    void addColor(int code, const std::string& name);
    std::string getColor(int code) const;
    int getColorNumber() const;
    std::map<int, std::string> getColorsForCodes(const std::vector<int>& codes) const;

private:
    int ColorNumber;
    std::map<int, std::string> colors;
};

#endif // COLOR_H