package com.example.lab9

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.lab9.model.HomeworkViewModel
import com.google.android.material.snackbar.Snackbar

class HomeworkAdapter(private val homeworkViewModel: HomeworkViewModel): RecyclerView.Adapter<HomeworkAdapter.ViewHolder>() {
    private var hwList = homeworkViewModel.hwList.value

    class ViewHolder(view: View): RecyclerView.ViewHolder(view) {
        val hwTextView: TextView = view.findViewById(R.id.hwItem)
        val dateTextView: TextView = view.findViewById(R.id.hwDate)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        //create an instance of LayoutInflater
        val layoutInflater = LayoutInflater.from(parent.context)
        //inflate the view
        val itemViewHolder = layoutInflater.inflate(R.layout.hw_item, parent, false)
        return ViewHolder(itemViewHolder)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = hwList?.get(position)
        holder.hwTextView.text = item?.name ?: ""
        holder.dateTextView.text = item?.month + "/" + item?.day ?: ""
        //context menu
        holder.itemView.setOnCreateContextMenuListener(){menu, view, menuInfo ->
            //set the menu title
            menu.setHeaderTitle(R.string.delete)

            //add the choices to the menu
            menu.add(R.string.yes).setOnMenuItemClickListener {
                //remove item from view model
                homeworkViewModel.delete(item!!)
                Snackbar.make(view, R.string.deleteItem, Snackbar.LENGTH_LONG)
                    .setAction(R.string.action, null).show()
                true
            }
            menu.add(R.string.no)
        }
    }

    override fun getItemCount(): Int {
        if (hwList != null) {
            return hwList!!.size
        } else return 0
    }

    fun update(){
        hwList = homeworkViewModel.hwList.value
        notifyDataSetChanged()
    }

}