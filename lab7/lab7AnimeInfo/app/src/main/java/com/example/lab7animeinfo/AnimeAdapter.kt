package com.example.lab7animeinfo

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.lab7animeinfo.model.Anime

class AnimeAdapter(private val titleList: ArrayList<Anime>, private val clickListener:(Anime)->Unit): RecyclerView.Adapter<AnimeAdapter.ViewHolder>() {

    class ViewHolder(view: View): RecyclerView.ViewHolder(view){
        val animeTitleText: TextView = view.findViewById(R.id.animeTitle)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        val itemViewHolder = layoutInflater.inflate(R.layout.anime_item,parent,false)
        return ViewHolder(itemViewHolder)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val title = titleList[position]
        holder.animeTitleText.text = title.title
        holder.itemView.setOnClickListener{clickListener(title)}
    }

    override fun getItemCount() = titleList.size
}