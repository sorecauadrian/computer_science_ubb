#include "Color.h"

Color::Color(int n) : ColorNumber(n) {
    for (int code = 0; code < n; code++) {
        colors[code] = "";
    }
}

std::map<int, std::string> Color::getColors() const {
    return colors;
}

void Color::addColor(int code, const std::string& name) {
    colors[code] = name;
}

std::string Color::getColor(int code) const {
    auto it = colors.find(code);

    if (it != colors.end()) {
        return it->second;
    }

    return "";
}

int Color::getColorNumber() const {
    return ColorNumber;
}

std::map<int, std::string> Color::getColorsForCodes(const std::vector<int>& codes) const {
    std::map<int, std::string> result;

    for (size_t i = 0; i < codes.size(); i++) {
        std::string color = colors.at(codes[i]);
        result[i] = color;
    }

    return result;
}