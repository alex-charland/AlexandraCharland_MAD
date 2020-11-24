package com.example.lab8

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.ImageView
import android.widget.RadioButton
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    private var roomChoice = Hotel()
    var hotelMessage:String = ""
    var imageId:Int? = null
    var hotelFound = false
    private val REQUEST_CODE = 1
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        seeDetails.setOnClickListener {
            if(hotelFound){
                roomChoice.displayChoice(priceRange.selectedItemPosition, imageId!!, hotelMessage)
            }
            val intent = Intent(this, BookRoom :: class.java)
            intent.putExtra("hotelDesc", roomChoice.hotelDesc)
            intent.putExtra("hotelImage", roomChoice.hotelImage)
            intent.putExtra("hotelURL", roomChoice.hotelUrl)
            startActivityForResult(intent, REQUEST_CODE)
        }
    }

    fun getHotel(view: View) {
        note.setText("")
        var roomChoice:CharSequence = ""
        var features = ""
        val roomId = roomType.checkedRadioButtonId
        if(roomId == -1){
            val roomError = Snackbar.make(stayPage,"Select a room type",Snackbar.LENGTH_SHORT)
            roomError.show()
        }
        else{
            roomChoice = findViewById<RadioButton>(roomId).text
            val price = "" + priceRange.selectedItem
            var roomPrice = 0
            if (price == "Any"){
                if(roomChoice == "Single"){
                    roomPrice = 59
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    hotelFound = true
                    imageId = R.drawable.holidayinnsingle
                }
                else if(roomChoice == "Double"){
                    roomPrice = 74
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    hotelFound = true
                    imageId = R.drawable.holidayinndouble
                }
                else if(roomChoice == "Suite"){
                    roomPrice = 105
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    hotelFound = true
                    imageId = R.drawable.holidayinnsuite
                }
                else{
                    roomPrice = 15
                    roomChoice = "Shack"
                    hotelMessage="$roomChoice room$features. Price per night: \$$roomPrice"
                    hotelFound = true
                    imageId = R.drawable.shack
                }

            }
            else if(price == "$30-$100") {
                if (roomChoice == "Double") {
                    roomPrice = 74
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    hotelFound = true
                    imageId = R.drawable.holidayinndouble
                }
                else if(roomChoice == "Suite"){
                    hotelMessage = "No $roomChoice rooms available at chosen price range"
                    hotelFound = false
                    imageId = android.R.color.transparent
                }
                else{
                    roomChoice = "Single"
                    roomPrice = 59
                    hotelMessage = "Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    hotelFound = true
                    imageId = R.drawable.holidayinnsingle
                }
            }
            else{
                if (roomChoice == "Single") {
                    hotelMessage = "No $roomChoice rooms available at chosen price range"
                    hotelFound = false
                    imageId = android.R.color.transparent
                }
                else if (roomChoice == "Double") {
                    hotelMessage = "No $roomChoice rooms available at chosen price range"
                    hotelFound = false
                    imageId = android.R.color.transparent
                }
                else{
                    roomChoice = "Suite"
                    roomPrice = 105
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    hotelFound = true
                    imageId = R.drawable.holidayinnsuite
                }

            }
            showResult()
        }
    }

    fun showResult(){
        hotelResult.text = hotelMessage
        if(hotelFound){
            seeDetails.visibility = View.VISIBLE
        }
        else{
            seeDetails.visibility = View.INVISIBLE
        }
        //imageId?.let { imageView.setImageResource(it) }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putString("MESSAGE",hotelMessage)
        outState.putBoolean("FOUND",hotelFound)
        imageId?.let{outState.putInt("image", it)}
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
        hotelFound = savedInstanceState.getBoolean("FOUND")
        hotelMessage = savedInstanceState.getString("MESSAGE", "")
        imageId = savedInstanceState.getInt("image")
        showResult()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if((requestCode == REQUEST_CODE) && (resultCode == Activity.RESULT_OK)){
            note.setText(data?.let{data.getStringExtra("note")})
        }
    }
}
