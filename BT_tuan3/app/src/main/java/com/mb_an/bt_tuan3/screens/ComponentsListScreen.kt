package com.mb_an.bt_tuan3.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class UIComponent(
    val id: String,
    val name: String,
    val description: String,
    val icon: ImageVector,
    val category: String
)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ComponentsListScreen(onComponentClick: (String) -> Unit) {
    val displayComponents = listOf(
        UIComponent("text", "Text", "Displays text", Icons.Default.Title, "Display"),
        UIComponent("image", "Image", "Displays an image", Icons.Default.Image, "Display")
    )

    val inputComponents = listOf(
        UIComponent("textfield", "TextField", "Input field for text", Icons.Default.Edit, "Input"),
        UIComponent("passwordfield", "PasswordField", "Input field for passwords", Icons.Default.Lock, "Input")
    )

    val layoutComponents = listOf(
        UIComponent("column", "Column", "Arranges elements vertically", Icons.Default.ViewColumn, "Layout"),
        UIComponent("row", "Row", "Arranges elements horizontally", Icons.Default.ViewWeek, "Layout")
    )

    Column(
        modifier = Modifier.fillMaxSize()
    ) {
        TopAppBar(
            title = {
                Text(
                    text = "UI Components List",
                    color = Color(0xFF2196F3),
                    fontWeight = FontWeight.SemiBold
                )
            }
        )

        LazyColumn(
            modifier = Modifier.fillMaxSize(),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            // Display Section
            item {
                SectionHeader("Display")
            }
            items(displayComponents) { component ->
                ComponentItem(
                    component = component,
                    onClick = { onComponentClick(component.id) }
                )
            }

            // Input Section
            item {
                Spacer(modifier = Modifier.height(16.dp))
                SectionHeader("Input")
            }
            items(inputComponents) { component ->
                ComponentItem(
                    component = component,
                    onClick = { onComponentClick(component.id) }
                )
            }

            // Layout Section
            item {
                Spacer(modifier = Modifier.height(16.dp))
                SectionHeader("Layout")
            }
            items(layoutComponents) { component ->
                ComponentItem(
                    component = component,
                    onClick = { onComponentClick(component.id) }
                )
            }

            // Search Section - Tự tìm hiểu
            item {
                Spacer(modifier = Modifier.height(16.dp))
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    colors = CardDefaults.cardColors(containerColor = Color(0xFFFFCDD2)),
                    shape = RoundedCornerShape(12.dp)
                ) {
                    Column(
                        modifier = Modifier.padding(16.dp)
                    ) {
                        Text(
                            text = "Tự tìm hiểu",
                            fontSize = 18.sp,
                            fontWeight = FontWeight.Bold,
                            color = Color.Black
                        )
                        Text(
                            text = "Tìm ra tất cả các thành phần UI Cơ bản",
                            fontSize = 14.sp,
                            color = Color.Gray,
                            modifier = Modifier.padding(top = 4.dp)
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun SectionHeader(title: String) {
    Text(
        text = title,
        fontSize = 16.sp,
        fontWeight = FontWeight.Medium,
        color = Color.Black,
        modifier = Modifier.padding(vertical = 8.dp)
    )
}

@Composable
fun ComponentItem(
    component: UIComponent,
    onClick: () -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() },
        colors = CardDefaults.cardColors(containerColor = Color(0xFFE3F2FD)),
        shape = RoundedCornerShape(12.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                imageVector = component.icon,
                contentDescription = component.name,
                tint = Color(0xFF1976D2),
                modifier = Modifier.size(24.dp)
            )

            Spacer(modifier = Modifier.width(16.dp))

            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = component.name,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color(0xFF1976D2)
                )
                Text(
                    text = component.description,
                    fontSize = 14.sp,
                    color = Color(0xFF1565C0),
                    modifier = Modifier.padding(top = 2.dp)
                )
            }
        }
    }
}