package com.example.lab8advice.model

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class AdviceViewModel : ViewModel() {
    val adviceList = MutableLiveData<ArrayList<Advice>>()
}