package com.example.lab9.util

import android.content.Context
import com.example.lab9.model.Homework

class HomeworkData {
    private val prefs_file = "HOMEWORK2"

    fun saveDataSharedPrefs(homeworkList: ArrayList<Homework>, context: Context) {
        val sharedPrefs = context.getSharedPreferences(prefs_file, Context.MODE_PRIVATE)
        val editor = sharedPrefs.edit()
        if (homeworkList != null) {
            editor.putInt("size", homeworkList.size)
        }
        for ((index, hw) in homeworkList.withIndex()){
            editor.putString("hw$index", hw.name)
            editor.putString("month$index", hw.month)
            editor.putString("day$index",hw.day)
        }
        editor.apply()
    }

    fun loadDataSharedPrefs(context: Context):ArrayList<Homework>{
        var loadedItemList = ArrayList<Homework>()
        val sharedPrefs = context.getSharedPreferences(prefs_file, Context.MODE_PRIVATE)
        val size = sharedPrefs.getInt("size", 0)
        for (i in 0 until size){
            loadedItemList.add(Homework(sharedPrefs.getString("hw$i", "")!!,sharedPrefs.getString("month$i", "")!!,sharedPrefs.getString("day$i", "")!!))
        }
        return loadedItemList
    }
}