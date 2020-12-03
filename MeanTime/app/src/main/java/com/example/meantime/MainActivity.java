package com.example.meantime;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.os.SystemClock;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Chronometer;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener{

    //TextView timer;
    Chronometer timer;
    Spinner chooseTask;
    ImageButton leftButton, rightButton;
    ListView taskList;
    List<String> stringTasks = new ArrayList<String>();
    String selection;
    DatabaseHelper taskdb;
    ArrayAdapter<TaskInfo> tableAdapter;
    ArrayAdapter<String> spinnerAdapter;
    boolean timerReady = false;
    boolean timerRunning = false;
    boolean timerPaused = false;
    long pauseOffset, time;
    int imageId = -1;
    String currentTimerVal;
    int currentTaskPosition;
    String hrsStr, minStr, secStr;
    int hours, minutes, seconds;
    List<Integer> oldtime = new ArrayList<Integer>();
    int oldhours, oldminutes, oldseconds, olditerations;
    int newhours,newminutes,newseconds, newiterations;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        timer = findViewById(R.id.timer);
        chooseTask = findViewById(R.id.chooseTask);
        leftButton = findViewById(R.id.leftButton);
        rightButton = findViewById(R.id.rightButton);
        taskList = findViewById(R.id.taskList);
        taskdb = new DatabaseHelper(MainActivity.this);
        DisplayTasksInTable(taskdb);
        timer.setText("00:00:00");


        //Fill the spinner
        fillTheSpinner();

        //ON CLICK LISTENERS
        chooseTask.setOnItemSelectedListener(this);
        //DELETE TASK FROM TABLE
        taskList.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, int position, long id) {
                TaskInfo task = (TaskInfo) parent.getItemAtPosition(position);
                boolean b = taskdb.deleteTask(task);
                Toast.makeText(MainActivity.this,"Task Deleted",Toast.LENGTH_SHORT);
                DisplayTasksInTable(taskdb);
                fillTheSpinner();
                return false;
            }
        });
        //TIMER TICKING DISPLAY
        timer.setOnChronometerTickListener(new Chronometer.OnChronometerTickListener() {
            @Override
            public void onChronometerTick(Chronometer chronometer) {
                time = SystemClock.elapsedRealtime() - chronometer.getBase();
                int hours = (int)(time/3600000);
                int minutes = (int)(time - hours*3600000)/60000;
                int seconds= (int)(time - hours*3600000- minutes*60000)/1000 ;
                String hh = hours < 10 ? "0"+hours: hours+"";
                String mm = minutes < 10 ? "0"+minutes: minutes+"";
                String ss = seconds < 10 ? "0"+seconds: seconds+"";
                currentTimerVal = hh+":"+mm+":"+ss;
                hrsStr = hh;
                minStr = mm;
                secStr = ss;
                chronometer.setText(currentTimerVal);
            }
        });
    }

    //CHECK IF TASK NAME ALREADY EXISTS
    private boolean checkName(String taskName){
        if(!stringTasks.contains(taskName)){
            return false;
        }
        return true;
    }
    //FILL THE SPINNER WITH TASK NAMES FROM DATABASE
    private void fillTheSpinner() {
        populateSpinner();
        spinnerAdapter = new ArrayAdapter<String>(MainActivity.this, android.R.layout.simple_spinner_item, stringTasks);
        spinnerAdapter.setDropDownViewResource(android.R.layout.simple_dropdown_item_1line);
        chooseTask.setAdapter(spinnerAdapter);
    }
    //RETRIEVE TASK NAMES FROM DATABASE
    private void populateSpinner(){
        stringTasks.clear();
        stringTasks.add("Select Task");
        stringTasks.addAll(taskdb.getTaskNames());
        stringTasks.add("Add Task");
    }
    //SPINNER ITEM SELECTED HANDLER
    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        selection = String.valueOf(parent.getItemAtPosition(position));
        if (selection.equals("Add Task")){//CREATE DIALOG FOR ADDING A TASK
            AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this, R.style.Theme_AppCompat_Dialog);
            View dialogLayout = getLayoutInflater().inflate(R.layout.select_task,null);
            builder.setView(dialogLayout);
            builder.setTitle("Add a new task");
            builder.setPositiveButton("Done", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    TaskInfo task;
                    EditText newTask = dialogLayout.findViewById(R.id.newTask);
                    if(!checkName(newTask.getText().toString()) && !newTask.getText().toString().equals("")){//ADD NEW TASK IF THE SAME TASK NAME DOES NOT EXIST IN THE DATABASE
                        task = new TaskInfo(-1,newTask.getText().toString(),0,0,0,0);
                        boolean success = taskdb.addTask(task);
                        if (success) {
                            DisplayTasksInTable(taskdb);
                            fillTheSpinner();
                            //Set spinner choice to be the recently added task
                            chooseTask.setSelection(position);
                            currentTaskPosition = position - 1;
                        }
                    }
                    else{
                        Toast.makeText(MainActivity.this,"Task already exists or is empty",Toast.LENGTH_SHORT).show();
                    }
                }
            });
            builder.setNeutralButton("Cancel",(dialog, which) -> {
                Toast.makeText(MainActivity.this,"Add task cancelled",Toast.LENGTH_SHORT).show();
            });
            AlertDialog dialog = builder.create();
            dialog.show();
        }
        else if(selection == "Select Task"){
            timerReady = false;
            changeButtons();
        }
        else{
            timerReady = true;
            changeButtons();

        }
    }
    //CHANGE THE STYLE OF THE BUTTONS FOR DIFFERENT TIMER STATES
    public void changeButtons(){
        if(timerReady && !timerRunning && !timerPaused){ //Start
            leftButton.setImageResource(R.drawable.startgreen);
        }
        else if(timerRunning && timerReady){ //Pause/End
            leftButton.setImageResource(R.drawable.pause);
            rightButton.setImageResource(R.drawable.endred);
        }
        else if(timerPaused && !timerRunning){//Start/End
            leftButton.setImageResource(R.drawable.startgreen);
            rightButton.setImageResource(R.drawable.endred);
        }
        else if (!timerReady){//End
            leftButton.setImageResource(R.drawable.startgrey);
            rightButton.setImageResource(R.drawable.endgrey);
        }
    }
    //ONCLICK BUTTON METHODS FOR STARTING/PAUSING THE TIMER
    public void startTimer(View view){
        if(timerReady && !timerRunning){
            timer.setBase(SystemClock.elapsedRealtime() - pauseOffset);
            timer.start();
            timerRunning = true;
            timerPaused = false;
            changeButtons();
        }
        else if (timerRunning && timerReady){
            timer.stop();
            pauseOffset = SystemClock.elapsedRealtime() - timer.getBase();
            timerPaused = true;
            timerRunning = false;
            changeButtons();
        }
        else{
            Toast.makeText(MainActivity.this,"Please select an existing task or add a new task",Toast.LENGTH_SHORT).show();
        }
    }
    //WHEN THE TIMER IS ENDED, CALCULATE THE AVERAGE TIME FOR THE TASK AND STORE IT IN THE DATABASE
    public void endTimer(View view){
        if(timerReady && (timerRunning || timerPaused)){
            timer.stop();
            hours = Integer.parseInt(hrsStr);
            minutes = Integer.parseInt(minStr);
            seconds = Integer.parseInt(secStr);
            oldtime = taskdb.getOldAverage(selection);
            oldhours = oldtime.get(0);
            oldminutes = oldtime.get(1);
            oldseconds = oldtime.get(2);
            olditerations = oldtime.get(3);
            calculateAverage();
            //RESET THE TIMER TO 0
            timer.setBase(SystemClock.elapsedRealtime());
            pauseOffset = 0;
            timerPaused = false;
            timerRunning = false;
            timerReady = false;
            timer.setText("00:00:00");
            changeButtons();
            chooseTask.setSelection(0);
            DisplayTasksInTable(taskdb);
        }

    }
    //FUNCTION FOR CALCULATING AVERAGE AND UPDATING THE DATABASE
    private void calculateAverage(){
        newiterations = olditerations + 1;
        newhours = oldhours + ((hours - oldhours) / newiterations);
        newminutes = oldminutes + ((minutes - oldminutes)/newiterations);
        while(newminutes > 60){
            newminutes = newminutes % 60;
            newhours = newhours + 1;
        }
        newseconds = oldseconds + ((seconds - oldseconds) / newiterations);
        while(newseconds > 60){
            newseconds = newseconds % 60;
            newminutes = newminutes + 1;
        }
        taskdb.updateTask(selection,newhours,newminutes,newseconds,newiterations);
    }
    //LOAD ALL THE TASKS FROM THE DATABASE
    private void DisplayTasksInTable(DatabaseHelper taskdb) {
        tableAdapter = new ArrayAdapter<TaskInfo>(MainActivity.this, android.R.layout.simple_list_item_1, taskdb.displayAll());
        taskList.setAdapter(tableAdapter);
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }


    @Override
    public void onSaveInstanceState(@NonNull Bundle savedInstanceState) {

        savedInstanceState.putBoolean("READY",timerReady);
        savedInstanceState.putBoolean("RUNNING",timerRunning);
        savedInstanceState.putBoolean("PAUSED",timerPaused);

        savedInstanceState.putLong("BASE",timer.getBase());

        savedInstanceState.putString("TIMER",currentTimerVal);
//        savedInstanceState.putInt("TASK",currentTaskPosition);
        savedInstanceState.putLong("OFFSET",pauseOffset);
        super.onSaveInstanceState(savedInstanceState);
    }

    @Override
    public void onRestoreInstanceState(@Nullable Bundle savedInstanceState) {

        timerReady = savedInstanceState.getBoolean("READY");
        timerRunning = savedInstanceState.getBoolean("RUNNING");
        timerPaused = savedInstanceState.getBoolean("PAUSED");
        currentTimerVal = savedInstanceState.getString("TIMER");
        pauseOffset = savedInstanceState.getLong("OFFSET");
        if(timerRunning || timerPaused){
            timer.setBase(savedInstanceState.getLong("BASE") - pauseOffset);
            if(timerPaused){
                timer.setText(currentTimerVal);
            }
        }
        super.onRestoreInstanceState(savedInstanceState);
        if(timerRunning){
            timer.start();
        }
        changeButtons();

    }
}

//TUTORIALS AND RESOURCES
//Stopwatch: https://www.youtube.com/watch?v=RLnb4vVkftc, https://stackoverflow.com/questions/4152569/how-to-change-format-of-chronometer/25391944, https://stackoverflow.com/questions/32079320/android-chronometer-save-time
//SQLite Database: https://www.youtube.com/watch?v=hDSVInZ2JCs, https://www.youtube.com/watch?v=PA4A9IesyCg
//ListView: https://www.youtube.com/watch?v=Mja5YoL9Jak
//Dialog: https://www.youtube.com/watch?v=xaxG54VulKk
