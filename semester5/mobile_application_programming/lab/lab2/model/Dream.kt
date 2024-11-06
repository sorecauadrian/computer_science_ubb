package com.example.akashic_dreams.model

data class Dream(
    val id: String,
    val date: String,
    val title: String,
    val description: String,
    val rating: Int,
    val lucidity: Boolean
)