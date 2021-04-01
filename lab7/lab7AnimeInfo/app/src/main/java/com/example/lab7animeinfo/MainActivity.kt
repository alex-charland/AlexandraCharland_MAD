package com.example.lab7animeinfo

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import androidx.appcompat.widget.Toolbar
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.lab7animeinfo.model.Anime
import com.example.lab7animeinfo.sample.AnimeData

class MainActivity : AppCompatActivity() {
    private var animeList = AnimeData.titleList
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val toolbar: Toolbar = findViewById(R.id.toolbar)
        setSupportActionBar(toolbar)

        val animeTable: RecyclerView = findViewById(R.id.animeTable)
        val adapter = AnimeAdapter(animeList,{title: Anime -> titleClicked(title)})
        animeTable.adapter = adapter
        animeTable.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL,false)
        animeTable.addItemDecoration(DividerItemDecoration(this,LinearLayoutManager.VERTICAL))
    }

    private fun titleClicked(title: Anime){
        val intent = Intent(this, AnimeDetail::class.java)
        intent.putExtra("title",title.title)
        intent.putExtra("imageID",title.imageId)
        intent.putExtra("URL",title.titleURL)
        startActivity(intent)
    }

}