package kr.co.domain;

import java.io.Serializable;

public class MemberDTO implements Serializable {

   /**
    * 
    */
   private static final long serialVersionUID = 1L;
   
   
   private String userId;
   private String userPw;
   private String userName;
   private String userEmail;
   private String userBirthday;
   private String userAddress;
   private String userRegdate;
   private String userUpdatedate;
   private int userGrade;
   
   public MemberDTO() {
      // TODO Auto-generated constructor stub
   }

public MemberDTO(String userId, String userPw, String userName, String userEmail, String userBirthday,
		String userAddress, String userRegdate, String userUpdatedate, int userGrade) {
	super();
	this.userId = userId;
	this.userPw = userPw;
	this.userName = userName;
	this.userEmail = userEmail;
	this.userBirthday = userBirthday;
	this.userAddress = userAddress;
	this.userRegdate = userRegdate;
	this.userUpdatedate = userUpdatedate;
	this.userGrade = userGrade;
}

public String getUserId() {
	return userId;
}

public void setUserId(String userId) {
	this.userId = userId;
}

public String getUserPw() {
	return userPw;
}

public void setUserPw(String userPw) {
	this.userPw = userPw;
}

public String getUserName() {
	return userName;
}

public void setUserName(String userName) {
	this.userName = userName;
}

public String getUserEmail() {
	return userEmail;
}

public void setUserEmail(String userEmail) {
	this.userEmail = userEmail;
}

public String getUserBirthday() {
	return userBirthday;
}

public void setUserBirthday(String userBirthday) {
	this.userBirthday = userBirthday;
}

public String getUserAddress() {
	return userAddress;
}

public void setUserAddress(String userAddress) {
	this.userAddress = userAddress;
}

public String getUserRegdate() {
	return userRegdate;
}

public void setUserRegdate(String userRegdate) {
	this.userRegdate = userRegdate;
}

public String getUserUpdatedate() {
	return userUpdatedate;
}

public void setUserUpdatedate(String userUpdatedate) {
	this.userUpdatedate = userUpdatedate;
}

public int getUserGrade() {
	return userGrade;
}

public void setUserGrade(int userGrade) {
	this.userGrade = userGrade;
}

public static long getSerialversionuid() {
	return serialVersionUID;
}

   

   
}