package com.mb_an.bt_tuan3.navigation

import android.window.SplashScreen
import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.mb_an.bt_tuan3.screens.ComponentsListScreen
import com.mb_an.bt_tuan3.screens.SplashScreen
import com.mb_an.bt_tuan3.screens.TextDetailScreen
import com.mb_an.bt_tuan3.screens.ImageDetailScreen
import com.mb_an.bt_tuan3.screens.TextFieldDetailScreen
import com.mb_an.bt_tuan3.screens.RowLayoutDetailScreen

@Composable
fun NavigationHost() {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = "splash"
    ) {
        composable("splash") {
            SplashScreen(
                onReady = {
                    navController.navigate("components_list") {
                        popUpTo("splash") { inclusive = true }
                    }
                }
            )
        }

        composable("components_list") {
            ComponentsListScreen(
                onComponentClick = { componentId ->
                    navController.navigate("component_detail/$componentId")
                }
            )
        }

        composable("component_detail/{componentId}") { backStackEntry ->
            val componentId = backStackEntry.arguments?.getString("componentId") ?: ""

            when (componentId) {
                "text" -> TextDetailScreen(
                    onBackClick = { navController.popBackStack() }
                )
                "image" -> ImageDetailScreen(
                    onBackClick = { navController.popBackStack() }
                )
                "textfield" -> TextFieldDetailScreen(
                    onBackClick = { navController.popBackStack() }
                )
                "row" -> RowLayoutDetailScreen(
                    onBackClick = { navController.popBackStack() }
                )
            }
        }
    }
}
