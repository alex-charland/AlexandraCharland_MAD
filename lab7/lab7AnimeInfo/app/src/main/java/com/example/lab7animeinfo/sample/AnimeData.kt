package com.example.lab7animeinfo.sample

import com.example.lab7animeinfo.R
import com.example.lab7animeinfo.model.Anime

object AnimeData {
    val titleList = ArrayList<Anime>()
    init {
        titleList.add(Anime("Attack on Titan", R.drawable.aot,"https://myanimelist.net/anime/16498/Shingeki_no_Kyojin?q=attack&cat=anime"))
        titleList.add(Anime("Clannad",R.drawable.cld,"https://myanimelist.net/anime/2167/Clannad"))
        titleList.add(Anime("Code Geass",R.drawable.cg,"https://myanimelist.net/anime/1575/Code_Geass__Hangyaku_no_Lelouch?q=code%20gea&cat=anime"))
        titleList.add(Anime("Fullmetal Alchemist",R.drawable.fma,"https://myanimelist.net/anime/121/Fullmetal_Alchemist?q=fullme&cat=anime"))
        titleList.add(Anime("My Hero Academia",R.drawable.mha,"https://myanimelist.net/anime/31964/Boku_no_Hero_Academia?q=boku%20no%20&cat=anime"))
        titleList.add(Anime("Neon Genesis Evangelion",R.drawable.nge,"https://myanimelist.net/anime/30/Neon_Genesis_Evangelion?q=neon%20gene&cat=anime"))
        titleList.add(Anime("One Piece",R.drawable.op,"https://myanimelist.net/anime/21/One_Piece"))
        titleList.add(Anime("Sword Art Online",R.drawable.sao,"https://myanimelist.net/anime/11757/Sword_Art_Online?q=sword%20art%20on&cat=anime"))
        titleList.add(Anime("Re:Zero",R.drawable.rz,"https://myanimelist.net/anime/31240/Re_Zero_kara_Hajimeru_Isekai_Seikatsu?q=re&cat=anime"))

    }
}