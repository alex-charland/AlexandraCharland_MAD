package com.example.lab7animeinfo

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.widget.Toolbar

class AnimeDetail : AppCompatActivity() {
    private var titleURL:String? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_anime_detail)
        val toolbar: Toolbar = findViewById(R.id.toolbar2)
        setSupportActionBar(toolbar)

        val title = intent.getStringExtra("title")
        val imageID = intent.getIntExtra("imageID", -1)
        titleURL = intent.getStringExtra("URL")

        val animeImage: ImageView = findViewById(R.id.animeImage)
        animeImage.setImageResource(imageID)
        val animeTitle: TextView = findViewById(R.id.animeTitleDetail)
        animeTitle.text = title
    }
    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.toolbar_items, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        val intent = Intent()
        intent.action = Intent.ACTION_VIEW
        intent.data = titleURL?.let{ Uri.parse(titleURL)}
        if (intent.resolveActivity(packageManager) != null){
            startActivity(intent)
        }
        return true
    }
}