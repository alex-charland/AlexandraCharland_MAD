package com.example.lab9

import android.app.DatePickerDialog
import android.os.Build
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.DatePicker
import android.widget.EditText
import androidx.activity.viewModels
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.lab9.model.Homework
import com.example.lab9.model.HomeworkViewModel
import java.util.*

class MainActivity : AppCompatActivity() {

    private val viewModel: HomeworkViewModel by viewModels()
    private var year:Int = 0
    private var month:Int = 0
    private var day:Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(findViewById(R.id.toolbar))

        if (viewModel.hwList.value == null){
            viewModel.loadData()
        }

        val recyclerView: RecyclerView = findViewById(R.id.hwList)
        recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        val adapter = HomeworkAdapter(viewModel)
        recyclerView.adapter = adapter

        viewModel.hwList.observe(this, Observer {
            adapter.update()
            viewModel.saveData()
        })
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    @RequiresApi(Build.VERSION_CODES.N)
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        val dialog = AlertDialog.Builder(this)
        val editText = EditText(applicationContext)
        dialog.setView(editText)
        dialog.setTitle(R.string.addItem)

        dialog.setPositiveButton(R.string.add) { dialog, which ->
            val newItem = editText.text.toString()
            if (!newItem.isEmpty()){
                //https://www.journaldev.com/9976/android-date-time-picker-dialog
                val c = Calendar.getInstance()
                year = c[Calendar.YEAR]
                month = c[Calendar.MONTH]
                day = c[Calendar.DAY_OF_MONTH]
                val datePickerDialog = DatePickerDialog(
                    this,
                    object : DatePickerDialog.OnDateSetListener {
                        override fun onDateSet(
                            view: DatePicker?, year: Int,
                            monthOfYear: Int, dayOfMonth: Int
                        ) {
                            viewModel.add(Homework(newItem,monthOfYear.toString(),dayOfMonth.toString()))
                        }
                    }, year, month, day
                )
                datePickerDialog.show()
            }
        }
        dialog.setNegativeButton(R.string.cancel) { dialog, which ->
        }
        dialog.show()
        return true
    }
}