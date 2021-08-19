<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    ﻿<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
 <script>

function back(){

     alert("관리자 권한이 필요한 페이지입니다.");

    /*  history.go(-1); // 방법1 */

   /*   history.back(); //방법 2 */

  // location.href  ="/board/list" ; // 방법3
     location.href  ="/" ;
}

</script>



<body onload ="back()"></body>