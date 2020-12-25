package com.example.lab8

import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import kotlinx.android.synthetic.main.activity_book_room.*
import kotlinx.android.synthetic.main.activity_main.*

class BookRoom : AppCompatActivity() {
    private var hotelMessage:String? = null
    private var hotelURL:String? = null
    private var imageId:Int? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_book_room)
        hotelMessage = intent.getStringExtra("hotelDesc")
        hotelURL = intent.getStringExtra("hotelURL")
        imageId = intent.getIntExtra("hotelImage",0)
        displayResults()

        book.setOnClickListener{
            openWebsite()
        }
    }
    fun displayResults(){
        hotelResult2.text = hotelMessage
        imageId?.let { imageView.setImageResource(it) }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        imageId?.let{outState.putInt("image", it)}
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
        imageId = savedInstanceState.getInt("image")
        displayResults()
    }

    fun openWebsite(){
        var intent = Intent()
        intent.action = Intent.ACTION_VIEW
        intent.data = hotelURL?.let{Uri.parse(hotelURL)}

        if (intent.resolveActivity(packageManager) != null){
            startActivity(intent)
        }
    }

    override fun onBackPressed() {
        val data = Intent()
        data.putExtra("note", noteText.text.toString())
        setResult(Activity.RESULT_OK,data)
        super.onBackPressed()
        finish()
    }

}