package com.example.meantime;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
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
    long pauseOffset;
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
        timer.setText("00:00:00");
        chooseTask = findViewById(R.id.chooseTask);
        leftButton = findViewById(R.id.leftButton);
        rightButton = findViewById(R.id.rightButton);
        taskList = findViewById(R.id.taskList);
        taskdb = new DatabaseHelper(MainActivity.this);
        DisplayTasksInTable(taskdb);

        //Fill the spinner
        fillTheSpinner();

        //ON CLICK LISTENERS
        chooseTask.setOnItemSelectedListener(this);
        taskList.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, int position, long id) {
                TaskInfo task = (TaskInfo) parent.getItemAtPosition(position);
                boolean b = taskdb.deleteTask(task);
                DisplayTasksInTable(taskdb);
                fillTheSpinner();
                return false;
            }
        });
        timer.setOnChronometerTickListener(new Chronometer.OnChronometerTickListener() {
            @Override
            public void onChronometerTick(Chronometer chronometer) {
                long time = SystemClock.elapsedRealtime() - chronometer.getBase();
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
    private boolean checkName(String taskName){
        if(!stringTasks.contains(taskName)){
            return false;
        }
        return true;
    }

    private void fillTheSpinner() {
        populateSpinner();
        spinnerAdapter = new ArrayAdapter<String>(MainActivity.this, android.R.layout.simple_spinner_item, stringTasks);
        spinnerAdapter.setDropDownViewResource(android.R.layout.simple_dropdown_item_1line);
        chooseTask.setAdapter(spinnerAdapter);
    }

    private void populateSpinner(){
        stringTasks.clear();
        stringTasks.add("Select Task");
        stringTasks.addAll(taskdb.getTaskNames());
        stringTasks.add("Add Task");
    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        selection = String.valueOf(parent.getItemAtPosition(position));
        if (selection.equals("Add Task")){
            AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this, R.style.Theme_AppCompat_Dialog);
            View dialogLayout = getLayoutInflater().inflate(R.layout.select_task,null);
            builder.setView(dialogLayout);
            builder.setTitle("Add a new task");
            builder.setPositiveButton("Done", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    TaskInfo task;
                    EditText newTask = dialogLayout.findViewById(R.id.newTask);
                    if(!checkName(newTask.getText().toString())){
                        task = new TaskInfo(-1,newTask.getText().toString(),0,0,0,0);
                        boolean success = taskdb.addTask(task);
                        Toast.makeText(MainActivity.this, "Success = " + success, Toast.LENGTH_SHORT).show();
                        if (success) {
                            DisplayTasksInTable(taskdb);
                            fillTheSpinner();
                            //Set spinner choice to be the recently added task
                            chooseTask.setSelection(position);
                            currentTaskPosition = position - 1;
                        }
                    }
                    else{
                        Toast.makeText(MainActivity.this,"Task already exists",Toast.LENGTH_SHORT).show();
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

    public void changeButtons(){
        if(timerReady){
            leftButton.setImageResource(R.drawable.startgreen);
        }
        else if(timerRunning){
            leftButton.setImageResource(R.drawable.pause);
            rightButton.setImageResource(R.drawable.endred);
        }
        else if(timerPaused){
            leftButton.setImageResource(R.drawable.startgreen);
            rightButton.setImageResource(R.drawable.endred);
        }
        else{
            leftButton.setImageResource(R.drawable.startgrey);
            rightButton.setImageResource(R.drawable.endgrey);
        }
    }

    public void startTimer(View view){
        if(timerReady){
            timer.setBase(SystemClock.elapsedRealtime() - pauseOffset);
            timer.start();
            timerRunning = true;
            timerReady = false;
            timerPaused = false;
            changeButtons();
        }
        else if (timerRunning){
            timer.stop();
            pauseOffset = SystemClock.elapsedRealtime() - timer.getBase();
            timerPaused = true;
            timerReady = true;
            timerRunning = false;
            changeButtons();
        }
        else{
            Toast.makeText(MainActivity.this,"Please select an existing task or add a new task",Toast.LENGTH_SHORT).show();
        }
    }

    public void endTimer(View view){
        if(timerRunning){
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

    private void DisplayTasksInTable(DatabaseHelper taskdb) {
        tableAdapter = new ArrayAdapter<TaskInfo>(MainActivity.this, android.R.layout.simple_list_item_1, taskdb.displayAll());
        taskList.setAdapter(tableAdapter);
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }
}