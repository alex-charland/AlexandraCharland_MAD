package com.example.lab8advice.util

import android.content.Context
import android.util.Log
import com.android.volley.Request
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.example.lab8advice.model.Advice
import com.example.lab8advice.model.AdviceViewModel
import org.json.JSONException
import org.json.JSONObject

class JSONData {
    val api_url = "https://api.adviceslip.com/advice/search/is"
    fun loadJSON(context: Context, adviceViewModel: AdviceViewModel) {

        val url = api_url

        // instantiate the Volley request queue
        val queue = Volley.newRequestQueue(context)

        // Request a string response from the provided URL.
        val stringRequest = StringRequest(
            Request.Method.GET, url,
            { response ->
                parseJSON(response, adviceViewModel)
            },
            {
                Log.e("ERROR", error("request failed"))
            })

        // Add the request to the RequestQueue.
        queue.add(stringRequest)
    }

    fun parseJSON(response: String, adviceViewModel: AdviceViewModel){
        val dataList = ArrayList<Advice>()
        //create JSONObject
        try{
            val jsonObject = JSONObject(response)

            //create JSONArray with the value from the results key
            val slipArray = jsonObject.getJSONArray("slips")

            //loop through each object in the array
            for (i in 0 until slipArray.length()){
                val adviceObject = slipArray.getJSONObject(i)

                //get values
                val id = adviceObject.getInt("id")
                val advice = adviceObject.getString("advice")

                //create new movie object
                val newAdvice = Advice(id,advice)

                //add character object to our ArrayList
                dataList.add(newAdvice)
            }
        } catch (e: JSONException) {
            e.printStackTrace()
        }
        adviceViewModel.adviceList.value = dataList
    }
}