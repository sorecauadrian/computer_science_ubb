package com.example.akashic_dreams.ui.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.example.akashic_dreams.model.Dream

@Composable
fun DreamItem(dream: Dream, modifier: Modifier = Modifier) {
    Card(
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 8.dp),
        colors = CardDefaults.cardColors(
            containerColor = if (dream.lucidity) Color(0xFF800080) else Color(0xFFE3F2FD)
        ),
        elevation = CardDefaults.cardElevation(4.dp),
        shape = RoundedCornerShape(8.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(text = dream.title, style = MaterialTheme.typography.titleMedium)
            Text(text = dream.date, style = MaterialTheme.typography.bodySmall, color = Color.Gray)
            Text(text = dream.description, style = MaterialTheme.typography.bodyMedium)
            Text(text = "⭐".repeat(dream.rating), style = MaterialTheme.typography.bodySmall)
        }
    }
}