package xyz.xqsr.model;

public class Order {

	private int cid;
	private int uid;
	private int status;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "Status [cid=" + cid + ", uid=" + uid + ", status=" + status + "]";
	}
}
