package xyz.xqsr.model;

public class Admin {
	private int aid;
	private String aname;
	private String apassword;
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getAname() {
		return aname;
	}
	public void setAname(String aname) {
		this.aname = aname;
	}
	public String getApassword() {
		return apassword;
	}
	public void setApassword(String apassword) {
		this.apassword = apassword;
	}
	@Override
	public String toString() {
		return "Admin [aid=" + aid + ", aname=" + aname + ", apassword=" + apassword + "]";
	}
	
}
