package com.example.meantime;

public class TaskInfo {
    private int id;
    private String taskName;
    private int hours;
    private int minutes;
    private int seconds;
    private int iterations;

    //CONSTRUCTORS
    public TaskInfo() {
    }

    public TaskInfo(int id, String taskName, int hours, int minutes, int seconds, int iterations) {
        this.id = id;
        this.taskName = taskName;
        this.hours = hours;
        this.minutes = minutes;
        this.seconds = seconds;
        this.iterations = iterations;
    }
    //GETTERS AND SETTERS
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public int getHours() {
        return hours;
    }

    public void setHours(int hours) {
        this.hours = hours;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }

    public int getSeconds() {
        return seconds;
    }

    public void setSeconds(int seconds) {
        this.seconds = seconds;
    }

    public int getIterations() {
        return iterations;
    }

    public void setIterations(int iterations) {
        this.iterations = iterations;
    }

    //TO STRING METHOD

    @Override
    public String toString() {
        String hoursStr = String.valueOf(hours);
        String minutesStr = String.valueOf(minutes);
        String secondsStr = String.valueOf(seconds);
        if(hours < 10){
            hoursStr = "0" + hoursStr;
        }
        if(minutes < 10){
            minutesStr = "0" + minutesStr;
        }
        if(seconds < 10){
            secondsStr = "0" + secondsStr;
        }
        String combinedTime = "" + taskName + "     " + hoursStr + " : " + minutesStr + " : " + secondsStr;
        return combinedTime;
//        return "ChangedTaskInfo{" +
//                "taskName='" + taskName + '\'' +
//                ", hours=" + hours +
//                ", minutes=" + minutes +
//                ", seconds=" + seconds +
//                '}';
    }
}
