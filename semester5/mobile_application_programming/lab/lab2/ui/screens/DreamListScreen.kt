package com.example.akashic_dreams.ui.screens

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.akashic_dreams.repository.DreamRepository
import com.example.akashic_dreams.ui.components.DreamItem

@Composable
fun DreamListScreen(navController: NavController, dreamRepository: DreamRepository, modifier: Modifier = Modifier) {
    val uiList by remember { mutableStateOf(dreamRepository.getAllDreams()) }

    Box(modifier = modifier.fillMaxSize()) {
        LazyColumn(modifier = Modifier.fillMaxSize()) {
            item {
                Text(
                    text = "Dreams",
                    style = MaterialTheme.typography.headlineMedium,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    textAlign = TextAlign.Center
                )
            }
            items(uiList) { dream ->
                DreamItem(
                    dream = dream,
                    modifier = Modifier.clickable {
                        navController.navigate("dreamDetails/${dream.id}")
                    }
                )
            }
        }

        FloatingActionButton(
            onClick = {
                navController.navigate("addDream")
            },
            modifier = Modifier
                .align(Alignment.BottomEnd)
                .padding(16.dp)
        ) {
            Text("+")
        }
    }
}
