package com.example.akashic_dreams.utils

fun isValidDate(date: String): Boolean {
    val datePattern = Regex("\\d{2}\\.\\d{2}\\.\\d{4} \\d{2}:\\d{2}")
    return datePattern.matches(date)
}