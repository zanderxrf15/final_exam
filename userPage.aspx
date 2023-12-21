<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userPage.aspx.cs" Inherits="final_exam.userPage" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>

<%
    HttpSession session = HttpContext.Current.Session;

    if (session == null || session["user_name"] == null)
    {
        Response.Redirect("loginForm.aspx");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Page</title>

    <link rel="stylesheet" href="AdminStyle.css">
</head>
<body>

<div class="container">
    <div class="content">
        <h3>hi, <span>user</span></h3>
        <h1>welcome <span>@Session["user_name"]</span></h1>
        <p>this is a user page</p>
        <a href="loginForm.aspx" class="btn">login</a>
        <a href="registerForm.aspx" class="btn">register</a>
        <a href="logout.aspx" class="btn">logout</a>
    </div>
</div>

</body>
</html>
