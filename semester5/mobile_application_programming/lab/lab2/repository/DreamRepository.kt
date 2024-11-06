package com.example.akashic_dreams.repository;

import com.example.akashic_dreams.model.Dream;

class DreamRepository {
    private val dreams = mutableListOf<Dream>()

    init {
        dreams.addAll(listOf(
            Dream(id = "1", date = "01.10.2023 08:05", title = "Flying High", description = "Dreamt about flying over the mountains.", rating = 5, lucidity = true),
            Dream(id = "2", date = "15.10.2023 10:20", title = "Underwater Exploration", description = "Exploring the underwater world.", rating = 4, lucidity = false),
            Dream(id = "3", date = "02.11.2023 06:23", title = "Lost in a Maze", description = "Got lost in a mysterious maze.", rating = 3, lucidity = true),
            Dream(id = "4", date = "12.12.2023 17:50", title = "Meeting an Old Friend", description = "Met an old friend I haven't seen in years.", rating = 5, lucidity = false),
            Dream(id = "5", date = "01.10.2023 08:05", title = "Flying High", description = "Dreamt about flying over the mountains.", rating = 5, lucidity = false),
            Dream(id = "6", date = "15.10.2023 10:20", title = "Underwater Exploration", description = "Exploring the underwater world.", rating = 4, lucidity = false),
            Dream(id = "7", date = "02.11.2023 06:23", title = "Lost in a Maze", description = "Got lost in a mysterious maze.", rating = 3, lucidity = true),
            Dream(id = "8", date = "12.12.2023 17:50", title = "Meeting an Old Friend", description = "Met an old friend I haven't seen in years.", rating = 5, lucidity = true)
        ))
    }

    fun getAllDreams(): List<Dream> = dreams

    fun addDream(dream: Dream) {
        dreams.add(dream)
    }

    fun updateDream(updatedDream: Dream) {
        val index = dreams.indexOfFirst { it.id == updatedDream.id }
        if (index != -1) {
            dreams[index] = updatedDream
        }
    }

    fun deleteDream(dreamId: String?) {
        dreams.removeAll { it.id == dreamId }
    }

    fun findDreamById(dreamId: String?): Dream? {
        return dreams.find { it.id == dreamId }
    }
}
