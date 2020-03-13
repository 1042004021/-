package xyz.xqsr.model;

public class FinishOrder {
	private int cid;
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	private int uid;
	private String start;
	private String end;
	private int status;
	private String time;
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time =time;
	}
	@Override
	public String toString() {
		return "FinishOrder [cid=" + cid + ", uid=" + uid + ", start=" + start + ", end=" + end + ", status=" + status
				+ ", time=" + time + "]";
	}
	
}
