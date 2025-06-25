/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Time;

/**
 *
 * @author PC
 */
public class Shift {
    private int shiftsId;
    private Time startTime;
    private Time endTime;

    // getter + setter

    public int getShiftsId() {
        return shiftsId;
    }

    public void setShiftsId(int shiftsId) {
        this.shiftsId = shiftsId;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }
}

