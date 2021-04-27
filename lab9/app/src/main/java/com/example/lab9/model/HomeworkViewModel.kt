package com.example.lab9.model

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.example.lab9.util.HomeworkData

class HomeworkViewModel(application: Application) : AndroidViewModel(application){
    val hwList = MutableLiveData<ArrayList<Homework>>()
    private var newHwList = ArrayList<Homework>()
    val context = application.applicationContext
    val sharedPrefsData = HomeworkData()

    fun add(item: Homework){
        newHwList.add(item)
        hwList.value = newHwList
    }

    fun delete(item: Homework){
        newHwList.remove(item)
        hwList.value = newHwList
    }

    fun loadData(){
        newHwList = sharedPrefsData.loadDataSharedPrefs(context)
        hwList.value = newHwList
    }

    fun saveData(){
        hwList.value?.let{sharedPrefsData.saveDataSharedPrefs(hwList.value!!, context)}
    }
}