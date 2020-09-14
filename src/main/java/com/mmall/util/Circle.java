package com.mmall.util;
/**
 * 圆形类
 *
 */
public class Circle {
    private double r;
    private Point2D cc;

    public void setR(double a){
        r = a;
    }
    public void setCC(Point2D centerOfCir){
        cc = centerOfCir;
    }
    public double getR(){
        return r;
    }
    public Point2D getCC(){
        return cc;
    }
}