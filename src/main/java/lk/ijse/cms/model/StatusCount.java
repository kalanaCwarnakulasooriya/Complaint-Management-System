package lk.ijse.cms.model;

public class StatusCount {
    private int PENDING;
    private int RESOLVED;
    private int IN_PROGRESS;
    private int totalCount;

    public StatusCount(int PENDING, int RESOLVED, int IN_PROGRESS, int totalCount) {
        this.PENDING = PENDING;
        this.RESOLVED = RESOLVED;
        this.IN_PROGRESS = IN_PROGRESS;
        this.totalCount = totalCount;
    }

    public int getPENDING() {
        return PENDING;
    }

    public void setPENDING(int PENDING) {
        this.PENDING = PENDING;
    }

    public int getRESOLVED() {
        return RESOLVED;
    }

    public void setRESOLVED(int RESOLVED) {
        this.RESOLVED = RESOLVED;
    }

    public int getIN_PROGRESS() {
        return IN_PROGRESS;
    }

    public void setIN_PROGRESS(int IN_PROGRESS) {
        this.IN_PROGRESS = IN_PROGRESS;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }
}