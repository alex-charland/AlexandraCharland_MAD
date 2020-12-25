package com.example.lab8

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.RadioButton
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    var hotelMessage:String = ""
    var imageId:Int? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun getHotel(view: View) {
        var roomChoice:CharSequence = ""
        var features = ""
        val roomId = roomType.checkedRadioButtonId
        var displayImage = false
        if(showImage.isChecked){
            displayImage = true
        }
        if(roomId == -1){
            val roomError = Snackbar.make(stayPage,"Select a room type",Snackbar.LENGTH_SHORT)
            roomError.show()
        }
        else{
            roomChoice = findViewById<RadioButton>(roomId).text
            if(pets.isChecked){
                features += ", pets allowed"
            }
            if(smoking.isChecked){
                features += ", non-smoking"
            }
            if(wifi.isChecked){
                features += ", free wifi"
            }
            val price = "" + priceRange.selectedItem
            var roomPrice = 0
            if (price == "Any"){
                if(roomChoice == "Single"){
                    roomPrice = 59
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    if(displayImage){
                        imageId = R.drawable.holidayinnsingle
                    }
                    else{
                        imageId = android.R.color.transparent
                    }
                }
                else if(roomChoice == "Double"){
                    roomPrice = 74
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    if(displayImage){
                        imageId = R.drawable.holidayinndouble
                    }
                    else{
                        imageId = android.R.color.transparent
                    }
                }
                else if(roomChoice == "Suite"){
                    roomPrice = 105
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    if(displayImage){
                        imageId = R.drawable.holidayinnsuite
                    }
                    else{
                        imageId = android.R.color.transparent
                    }
                }
                else{
                    roomPrice = 15
                    roomChoice = "Shack"
                    hotelMessage="$roomChoice room$features. Price per night: \$$roomPrice"
                    if(displayImage){
                        imageId = R.drawable.shack
                    }
                    else{
                        imageId = android.R.color.transparent
                    }
                }

            }
            else if(price == "$30-$100") {
                if (roomChoice == "Double") {
                    roomPrice = 74
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    if(displayImage){
                        imageId = R.drawable.holidayinndouble
                    }
                    else{
                        imageId = android.R.color.transparent
                    }
                }
                else if(roomChoice == "Suite"){
                    hotelMessage = "No $roomChoice rooms available at chosen price range"
                    imageId = android.R.color.transparent
                }
                else{
                    roomChoice = "Single"
                    roomPrice = 59
                    hotelMessage = "Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    if(displayImage){
                        imageId = R.drawable.holidayinnsingle
                    }
                    else{
                        imageId = android.R.color.transparent
                    }
                }
            }
            else{
                if (roomChoice == "Single") {
                    hotelMessage = "No $roomChoice rooms available at chosen price range"
                    imageId = android.R.color.transparent
                }
                else if (roomChoice == "Double") {
                    hotelMessage = "No $roomChoice rooms available at chosen price range"
                    imageId = android.R.color.transparent
                }
                else{
                    roomChoice = "Suite"
                    roomPrice = 105
                    hotelMessage="Holiday Inn Express $roomChoice room$features. Price per night: \$$roomPrice"
                    if(displayImage){
                        imageId = R.drawable.holidayinnsuite
                    }
                    else{
                        imageId = android.R.color.transparent
                    }
                }

            }
            showResult()
        }
    }

    fun showResult(){
        hotelResult.text = hotelMessage
        imageId?.let { imageView.setImageResource(it) }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putString("MESSAGE",hotelMessage)
        imageId?.let{outState.putInt("image", it)}
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
        hotelMessage = savedInstanceState.getString("MESSAGE", "")
        imageId = savedInstanceState.getInt("image")
        showResult()
    }
}