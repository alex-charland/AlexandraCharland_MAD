package com.example.lab8advice

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.TextView
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import com.example.lab8advice.model.AdviceViewModel
import com.example.lab8advice.util.JSONData

class MainActivity : AppCompatActivity() {
    private val viewModel: AdviceViewModel by viewModels()
    lateinit var adviceText : TextView
    lateinit var adviceButton : Button
    var currIndex : Int = 0
    var advice = ""
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        adviceText = findViewById(R.id.adviceText)
        if (viewModel.adviceList.value == null){
            Log.i("main", "null values")
            val loader = JSONData()
            loader.loadJSON(this, viewModel)
            //viewModel.adviceList.value!!.size
        }
        viewModel.adviceList.observe(this, Observer {
            update()

        })
    }
    fun update(){
        if(currIndex == viewModel.adviceList.value!!.size){
            currIndex = 0
        }
        advice = viewModel.adviceList.value?.get(currIndex)?.advice ?: ""
        adviceText.text = advice
        currIndex = currIndex + 1
    }
    fun getNewAdvice(view: View){
        update()
    }

    //Create saved instance state for currIndex
    override fun onSaveInstanceState(outState: Bundle) {
        outState.putInt("INDEX",currIndex)
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
        currIndex = savedInstanceState.getInt("INDEX")
        if(currIndex == 0){
            currIndex = viewModel.adviceList.value!!.size - 1
        }
        else{
            currIndex = currIndex - 1
        }
        update()
    }
}