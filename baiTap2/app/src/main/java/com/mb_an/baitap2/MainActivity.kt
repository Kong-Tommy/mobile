package com.mb_an.baitap2

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.mb_an.baitap2.ui.theme.Baitap2Theme
import androidx.compose.foundation.layout.imePadding


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Baitap2Theme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = Color(0xFFF5F5F5) // Light gray background
                ) {
                    AgeCheckerApp()
                }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AgeCheckerApp() {
    var name by remember { mutableStateOf("") }
    var age by remember { mutableStateOf("") }
    var showResult by remember { mutableStateOf(false) }
    var nameError by remember { mutableStateOf("") }
    var ageError by remember { mutableStateOf("") }

    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(scrollState)
            .imePadding()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Top
    ) {

        Spacer(modifier = Modifier.height(40.dp))

        // Header Title
        Text(
            text = "Thực hành 01",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            color = Color.Black,
            textAlign = TextAlign.Center
        )

        Spacer(modifier = Modifier.height(40.dp))


        Card(
            modifier = Modifier
                .fillMaxWidth()

                .padding(horizontal = 16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFFD3D3D3)), // Gray background
            shape = RoundedCornerShape(12.dp),
            elevation = CardDefaults.cardElevation(defaultElevation = 0.dp)
        ) {
            Column(
                modifier = Modifier.padding(24.dp),
                verticalArrangement = Arrangement.spacedBy(20.dp)
            ) {

                // nhập tên
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    Text(
                        text = "Họ và tên",
                        fontSize = 16.sp,
                        color = Color.Black,
                        modifier = Modifier.width(80.dp)
                    )

                    TextField(
                        value = name,
                        onValueChange = {
                            name = it
                            nameError = ""
                        },
                        modifier = Modifier
                            .weight(2f)
                            .height(54.dp),
                        colors = TextFieldDefaults.colors(
                            unfocusedContainerColor = Color.White,
                            focusedContainerColor = Color.White,
                            unfocusedIndicatorColor = Color.Transparent,
                            focusedIndicatorColor = Color.Transparent,
                            errorContainerColor = Color.White
                        ),
                        shape = RoundedCornerShape(6.dp),
                        singleLine = true,
                        isError = nameError.isNotEmpty()
                    )
                }

                // nhập tủi
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    Text(
                        text = "Tuổi",
                        fontSize = 16.sp,
                        color = Color.Black,
                        modifier = Modifier.width(80.dp)
                    )

                    TextField(
                        value = age,
                        onValueChange = {
                            age = it
                            ageError = ""
                        },
                        modifier = Modifier
                            .weight(1f)
                            .height(54.dp),
                        colors = TextFieldDefaults.colors(
                            unfocusedContainerColor = Color.White,
                            focusedContainerColor = Color.White,
                            unfocusedIndicatorColor = Color.Transparent,
                            focusedIndicatorColor = Color.Transparent,
                            errorContainerColor = Color.White
                        ),
                        shape = RoundedCornerShape(6.dp),
                        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
                        singleLine = true,
                        isError = ageError.isNotEmpty()
                    )
                }
            }
        }

        Spacer(modifier = Modifier.height(24.dp))

        //kỉm tra isEmpty
        Button(
            onClick = {
                val validation = validateInput(name, age)
                nameError = validation.first
                ageError = validation.second

                if (nameError.isEmpty() && ageError.isEmpty()) {
                    showResult = true
                }
            },
            modifier = Modifier
                .width(120.dp)
                .height(40.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFF2196F3) // Blue color
            ),
            shape = RoundedCornerShape(6.dp)
        ) {
            Text(
                text = "Kiểm tra",
                color = Color.White,
                fontSize = 16.sp,
                fontWeight = FontWeight.Medium
            )
        }

        // thông báo li
        if (nameError.isNotEmpty()) {
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = nameError,
                color = MaterialTheme.colorScheme.error,
                fontSize = 14.sp
            )
        }

        if (ageError.isNotEmpty()) {
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = ageError,
                color = MaterialTheme.colorScheme.error,
                fontSize = 14.sp
            )
        }

        // Results Section
        if (showResult && name.isNotEmpty() && age.isNotEmpty() && nameError.isEmpty() && ageError.isEmpty()) {
            val ageInt = age.toIntOrNull() ?: 0
            val ageCategory = getAgeCategory(ageInt)

            Spacer(modifier = Modifier.height(32.dp))

            Card(
                modifier = Modifier
                    .fillMaxWidth()

                    .padding(horizontal = 16.dp),
                colors = CardDefaults.cardColors(containerColor = Color.White),
                shape = RoundedCornerShape(12.dp),
                elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
            ) {
                Column(
                    modifier = Modifier.padding(20.dp),
                    verticalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    Text(
                        text = "Kết quả kiểm tra",
                        modifier = Modifier.fillMaxWidth(),
                        textAlign = TextAlign.Center,
                        color = Color(0xFF2196F3),
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Bold
                    )

                    Text(
                        text = "Họ và tên: $name",
                        fontSize = 16.sp,
                        color = Color.Black
                    )

                    Text(
                        text = "Tuổi: $age",
                        fontSize = 16.sp,
                        color = Color.Black
                    )


                    Box(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 8.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Card(
                            colors = CardDefaults.cardColors(
                                containerColor = ageCategory.backgroundColor
                            ),
                            shape = RoundedCornerShape(8.dp)
                        ) {
                            Text(
                                text = ageCategory.category,
                                modifier = Modifier.padding(12.dp),
                                color = ageCategory.textColor,
                                fontSize = 16.sp,
                                fontWeight = FontWeight.Bold
                            )
                        }
                    }

                    Text(
                        text = ageCategory.description,
                        modifier = Modifier.fillMaxWidth(),
                        textAlign = TextAlign.Center,
                        fontSize = 14.sp,
                        color = Color.Gray,
                        lineHeight = 20.sp
                    )
                }
            }

            Spacer(modifier = Modifier.height(16.dp))

            // xóa
            OutlinedButton(
                onClick = {
                    name = ""
                    age = ""
                    nameError = ""
                    ageError = ""
                    showResult = false
                },
                modifier = Modifier.width(120.dp),
                colors = ButtonDefaults.outlinedButtonColors(
                    contentColor = Color(0xFF2196F3)
                )
            ) {
                Text("Xóa", fontSize = 16.sp)
            }
        }
    }
}

data class AgeCategoryInfo(
    val category: String,
    val description: String,
    val textColor: Color,
    val backgroundColor: Color
)

fun validateInput(name: String, age: String): Pair<String, String> {
    var nameError = ""
    var ageError = ""

    if (name.isBlank()) {
        nameError = "Vui lòng nhập họ tên"
    } else if (!name.matches(Regex("^[a-zA-ZÀ-ỹ\\s]+$"))) {
        nameError = "Họ và tên chỉ được chứa chữ cái"
    }

    val ageInt = age.toIntOrNull()
    if (age.isBlank()) {
        ageError = "Vui lòng nhập tuổi"
    } else if (ageInt == null || ageInt !in 0..150) {
        ageError = "Tuổi không hợp lệ (0-150)"
    }

    return Pair(nameError, ageError)
}


fun getAgeCategory(age: Int): AgeCategoryInfo {
    return when {
        age > 65 -> AgeCategoryInfo(
            category = "Người già",
            description = "Độ tuổi trên 65 - Người cao tuổi",
            textColor = Color(0xFF1976D2),
            backgroundColor = Color(0xFFE3F2FD)
        )
        age in 6..65 -> AgeCategoryInfo(
            category = "Người lớn",
            description = "Độ tuổi từ 6 đến 65 - Thế hệ cợt nhả gia nhập thị trường lao động",
            textColor = Color(0xFF2E7D32),
            backgroundColor = Color(0xFFE8F5E8)
        )
        age in 2..5 -> AgeCategoryInfo(
            category = "Trẻ em",
            description = "Độ tuổi từ 2 đến 5 - Trẻ con",
            textColor = Color(0xFFF57C00),
            backgroundColor = Color(0xFFFFF3E0)
        )
        else -> AgeCategoryInfo(
            category = "En bé",
            description = "Độ tuổi dưới 2 - Cần được chăm sóc đặc biệt",
            textColor = Color(0xFFC2185B),
            backgroundColor = Color(0xFFFCE4EC)
        )
    }
}

@Preview(showBackground = true)
@Composable
fun AgeCheckerAppPreview() {
    Baitap2Theme {
        Surface(color = Color(0xFFF5F5F5)) {
            AgeCheckerApp()
        }
    }
}