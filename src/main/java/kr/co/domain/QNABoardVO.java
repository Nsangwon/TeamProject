package kr.co.domain;

import java.io.Serializable;

public class QNABoardVO implements Serializable 
{
	private static final long serialVersionUID = 1L;
	private int qQno; //<!null
	private int qBno; //<!null
	private String qTitle; //<!null
	private String qWriter; //<!null
	private String qContent; //<!null
	private String qPassword; //<!null
	private String qRegdate;
	private String qUpdatedate;
	private int qReproot;
	private int qRepstep;
	private int qRepindent;
	private String qUserId;

	public QNABoardVO() {
		// TODO Auto-generated constructor stub
	}

	public QNABoardVO(int qQno, int qBno, String qTitle, String qWriter, String qContent, String qPassword, String qRegdate,
			String qUpdatedate, int qReproot, int qRepstep, int qRepindent, String qUserId) {
		super();
		this.qQno = qQno;
		this.qBno = qBno;
		this.qTitle = qTitle;
		this.qWriter = qWriter;
		this.qContent = qContent;
		this.qPassword = qPassword;
		this.qRegdate = qRegdate;
		this.qUpdatedate = qUpdatedate;
		this.qReproot = qReproot;
		this.qRepstep = qRepstep;
		this.qRepindent = qRepindent;
		this.qUserId = qUserId;
	}
	
	public String getqUserId() {
		return qUserId;
	}

	public void setqUserId(String qUserId) {
		this.qUserId = qUserId;
	}

	public int getqQno() {
		return qQno;
	}

	public void setqQno(int qQno) {
		this.qQno = qQno;
	}

	public int getqBno() {
		return qBno;
	}

	public void setqBno(int qBno) {
		this.qBno = qBno;
	}

	public String getqTitle() {
		return qTitle;
	}

	public void setqTitle(String qTitle) {
		this.qTitle = qTitle;
	}

	public String getqWriter() {
		return qWriter;
	}

	public void setqWriter(String qWriter) {
		this.qWriter = qWriter;
	}

	public String getqContent() {
		return qContent;
	}

	public void setqContent(String qContent) {
		this.qContent = qContent;
	}

	public String getqPassword() {
		return qPassword;
	}

	public void setqPassword(String qPassword) {
		this.qPassword = qPassword;
	}

	public String getqRegdate() {
		return qRegdate;
	}

	public void setqRegdate(String qRegdate) {
		this.qRegdate = qRegdate;
	}

	public String getqUpdatedate() {
		return qUpdatedate;
	}

	public void setqUpdatedate(String qUpdatedate) {
		this.qUpdatedate = qUpdatedate;
	}
	
	public int getqReproot() {
		return qReproot;
	}

	public void setqReproot(int qReproot) {
		this.qReproot = qReproot;
	}

	public int getqRepstep() {
		return qRepstep;
	}

	public void setqRepstep(int qRepstep) {
		this.qRepstep = qRepstep;
	}

	public int getqRepindent() {
		return qRepindent;
	}

	public void setqRepindent(int qRepindent) {
		this.qRepindent = qRepindent;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + qQno;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		QNABoardVO other = (QNABoardVO) obj;
		if (qQno != other.qQno)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "QnaVO [qQno=" + qQno + ", qBno=" + qBno + ", qTitle=" + qTitle + ", qWriter=" + qWriter + ", qUserId=" + qUserId + ", qContent="
				+ qContent + ", qPassword=" + qPassword + ", qRegdate=" + qRegdate + ", qUpdatedate=" + qUpdatedate
				+ ", qReproot=" + qReproot + ", qRepstep=" + qRepstep + ", qRepindent=" + qRepindent + "]\n";
	}
}
