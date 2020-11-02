package com.example.lab7

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun sayHello(view: View) {
        //Fill blank labels with name and attendance message
        val helloText = findViewById<TextView>(R.id.nameMessage)
        val attendanceText = findViewById<TextView>(R.id.attendanceText)
        val editName = findViewById<EditText>(R.id.editTextName)
        val name = editName.text
        helloText.setText("Glad you're here, "+name+"!")
        attendanceText.setText("Your attendance has been recorded.")
        //Display image
        val checkmark = findViewById<ImageView>(R.id.imageView)
        checkmark.setImageResource(R.drawable.checkmark)
    }
}