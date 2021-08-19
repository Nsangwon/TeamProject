package kr.co.persistence;

public interface KakaoPayDAO {

	void setTid(String tid);

	void deleteTid();

	String getTid();

	int getNum();

	void setONum(int orderNum, String string);

	String getId();

}
