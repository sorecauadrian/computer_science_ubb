package com.example.akashic_dreams

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.ui.Modifier
import com.example.akashic_dreams.ui.theme.Akashic_dreamsTheme
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.akashic_dreams.repository.DreamRepository
import com.example.akashic_dreams.ui.screens.DreamAddScreen
import com.example.akashic_dreams.ui.screens.DreamDetailsScreen
import com.example.akashic_dreams.ui.screens.DreamListScreen

class MainActivity : ComponentActivity()
{
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            val navController = rememberNavController()
            val dreamRepository = DreamRepository()

            Akashic_dreamsTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    NavHost(
                        navController = navController,
                        startDestination = "dreamList",
                        Modifier.padding(innerPadding)
                    ) {
                        composable("dreamList") {
                            DreamListScreen(navController = navController, dreamRepository = dreamRepository)
                        }
                        composable("dreamDetails/{dreamId}") { backStackEntry ->
                            val dreamId = backStackEntry.arguments?.getString("dreamId")
                            DreamDetailsScreen(dreamId = dreamId, navController = navController, dreamRepository = dreamRepository)
                        }
                        composable("addDream") {
                            DreamAddScreen(navController = navController, dreamRepository = dreamRepository)
                        }
                    }
                }
            }
        }
    }
}
