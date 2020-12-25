package com.example.meantime;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.List;

public class DatabaseHelper extends SQLiteOpenHelper {
    public static final String TASKS = "TASKS";
    public static final String ID = "ID";
    public static final String TASKNAME = "TASKNAME";
    public static final String HOURS = "HOURS";
    public static final String MINUTES = "MINUTES";
    public static final String SECONDS = "SECONDS";
    public static final String ITERATIONS = "ITERATIONS";

    public DatabaseHelper(@Nullable Context context) {
        super(context, "meantime2.db", null, 1);
    }

    //Create main table
    @Override
    public void onCreate(SQLiteDatabase db) {
        String createTable = "CREATE TABLE " + TASKS + " (" + ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + TASKNAME + " TEXT, " + HOURS + " INT, " + MINUTES + " INT, " + SECONDS + " INT, " + ITERATIONS + " INT);";
        db.execSQL(createTable);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        String query = "DROP TABLE IF EXISTS " + TASKS;
        db.execSQL(query);
    }


    //Add a new task to the database
    public boolean addTask(TaskInfo task){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(TASKNAME,task.getTaskName());
        contentValues.put(HOURS,task.getHours());
        contentValues.put(MINUTES,task.getMinutes());
        contentValues.put(SECONDS,task.getSeconds());
        contentValues.put(ITERATIONS,task.getIterations());
        long insert = db.insert(TASKS,null,contentValues);
        if (insert == -1){
            return false;
        }
        return true;
    }

    public boolean deleteTask(TaskInfo task){
        SQLiteDatabase db = this.getWritableDatabase();
        String query = "DELETE FROM " + TASKS + " WHERE " + ID + " = " + task.getId();
        Cursor cursor = db.rawQuery(query, null);
        if(cursor.moveToFirst()){
            return true;
        }
        return false;
    }

    public boolean updateTask(String task, int hours, int minutes, int seconds, int iterations){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(HOURS, hours);
        contentValues.put(MINUTES,minutes);
        contentValues.put(SECONDS,seconds);
        contentValues.put(ITERATIONS,iterations);
        long update = db.update(TASKS,contentValues,"" + TASKNAME + " = ?", new String[] {task});
        if(update == -1){
            return false;
        }
        return true;
    }

    //Display tasks in table
    public List<TaskInfo> displayAll(){
        SQLiteDatabase db = this.getReadableDatabase();
        List<TaskInfo> allTasks = new ArrayList<>();
        String query = "SELECT * FROM " + TASKS + ";";
        Cursor cursor = db.rawQuery(query,null);
        if(cursor.moveToFirst()){
            do {
                int taskID = cursor.getInt(0);
                String taskName = cursor.getString(1);
                int hours = cursor.getInt(2);
                int minutes = cursor.getInt(3);
                int seconds = cursor.getInt(4);
                int iterations = cursor.getInt(5);
                TaskInfo task = new TaskInfo(taskID,taskName,hours,minutes,seconds,iterations);
                allTasks.add(task);
            }while(cursor.moveToNext());
        }
        return allTasks;
    }

    //Format for populating spinner
    public List<String> getTaskNames(){
        SQLiteDatabase db = this.getReadableDatabase();
        List<String> allTasks = new ArrayList<>();
        String query = "SELECT " + TASKNAME + " FROM " + TASKS + ";";
        Cursor cursor = db.rawQuery(query,null);
        if(cursor.moveToFirst()){
            do{
                String taskName = cursor.getString(0);
                allTasks.add(taskName);
            }while(cursor.moveToNext());
        }
        return allTasks;
    }

    //Get current time info for averaging
    public List<Integer> getOldAverage(String task){
        SQLiteDatabase db = this.getReadableDatabase();
        List<Integer> time = new ArrayList<>();
        String query = "SELECT * FROM " + TASKS + " WHERE " + TASKNAME + " = ?";
        Cursor cursor = db.rawQuery(query,new String[] {task});
        if(cursor.moveToFirst()){
            int hours = cursor.getInt(2);
            int minutes = cursor.getInt(3);
            int seconds = cursor.getInt(4);
            int iterations = cursor.getInt(5);
            time.add(hours);
            time.add(minutes);
            time.add(seconds);
            time.add(iterations);
        }
        return time;
    }

}
