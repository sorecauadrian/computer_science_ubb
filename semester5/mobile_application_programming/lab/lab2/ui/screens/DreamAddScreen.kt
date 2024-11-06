package com.example.akashic_dreams.ui.screens

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.akashic_dreams.utils.isValidDate
import com.example.akashic_dreams.model.Dream
import com.example.akashic_dreams.repository.DreamRepository
import java.util.UUID

@Composable
fun DreamAddScreen(navController: NavController, dreamRepository: DreamRepository) {
    var title by remember { mutableStateOf("") }
    var date by remember { mutableStateOf("") }
    var description by remember { mutableStateOf("") }
    var rating by remember { mutableIntStateOf(1) }
    var lucidity by remember { mutableStateOf(false) }

    var titleError by remember { mutableStateOf(false) }
    var dateError by remember { mutableStateOf(false) }
    var descriptionError by remember { mutableStateOf(false) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        Text(text = "Add New Dream", modifier = Modifier.fillMaxWidth().padding(16.dp), textAlign = TextAlign.Center, style = MaterialTheme.typography.headlineMedium)

        Spacer(modifier = Modifier.height(16.dp))

        TextField(
            value = title,
            onValueChange = {
                title = it
                titleError = it.isBlank()
            },
            label = { Text("Title") },
            modifier = Modifier.fillMaxWidth()
        )

        if (titleError) {
            Text(
                text = "Title cannot be empty",
                color = MaterialTheme.colorScheme.error,
                style = MaterialTheme.typography.bodySmall
            )
        }

        Spacer(modifier = Modifier.height(8.dp))

        TextField(
            value = date,
            onValueChange = {
                date = it
                dateError = !isValidDate(it) || it.isBlank()
            },
            label = { Text("Date (dd.MM.yyyy HH:mm)") },
            modifier = Modifier.fillMaxWidth()
        )

        if (dateError) {
            Text(
                text = "Invalid date format. Use dd.MM.yyyy HH:mm",
                color = MaterialTheme.colorScheme.error,
                style = MaterialTheme.typography.bodySmall
            )
        }

        Spacer(modifier = Modifier.height(8.dp))

        TextField(
            value = description,
            onValueChange = {
                description = it
                descriptionError = it.isBlank()
            },
            label = { Text("Description") },
            modifier = Modifier.fillMaxWidth()
        )

        if (descriptionError) {
            Text(
                text = "Description cannot be empty",
                color = MaterialTheme.colorScheme.error,
                style = MaterialTheme.typography.bodySmall
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        Text(text = "Rating", style = MaterialTheme.typography.titleMedium)

        Row(modifier = Modifier.padding(start = 16.dp)) {
            for (i in 1..5) {
                RadioButton(
                    selected = (rating == i),
                    onClick = { rating = i }
                )
                Text(text = "$i", modifier = Modifier.padding(start = 4.dp).align(Alignment.CenterVertically))
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        Row(verticalAlignment = Alignment.CenterVertically) {
            Text(text = "Lucid Dream")
            Spacer(modifier = Modifier.width(8.dp))
            Switch(
                checked = lucidity,
                onCheckedChange = { lucidity = it }
            )
        }

        Spacer(modifier = Modifier.height(24.dp))

        Button(
            onClick = {
                titleError = title.isBlank()
                dateError = !isValidDate(date) || date.isBlank()
                descriptionError = description.isBlank()
                if (!titleError && !dateError && !descriptionError) {
                    dreamRepository.addDream(
                        Dream(
                            id = UUID.randomUUID().toString(),
                            date = date,
                            title = title,
                            description = description,
                            rating = rating,
                            lucidity = lucidity
                        )
                    )
                    navController.popBackStack()
                }
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Add Dream")
        }
    }
}