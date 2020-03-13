package xyz.xqsr.model;

public class Ticket {
	private int cid;
	private int uid;
	private String time;


	private String start;
	private String end;
	private int quantity;
	
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
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@Override
	public String toString() {
		return "Ticket [cid=" + cid + ", uid=" + uid + ", time=" + time + ", start=" + start + ", end=" + end
				+ ", quantity=" + quantity + "]";
	}
	
}
