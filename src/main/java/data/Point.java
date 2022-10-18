package data;

public class Point {
    private final double x, y, r;
    private final String execTime;
    private final boolean isInside;
    private final long time;

    public Point() {
        x = 0;
        y = 0;
        r = 0;
        execTime = "";
        isInside = false;
        time = 0;
    }
    public Point(double x, double y, double r, String execTime, boolean isInside, long time) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.execTime = execTime;
        this.isInside = isInside;
        this.time = time;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public String getExecTime() {
        return execTime;
    }

    public boolean isInside() {
        return isInside;
    }

    public long getTime() {
        return time;
    }
}
