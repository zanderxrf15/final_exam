<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="config.aspx.cs" Inherits="final_exam.config" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.SessionState" %>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>admin page</title>

   <link rel="stylesheet" href="AdminStyle.css">
</head>
<body>
   <div class="container">
      <div class="content">
         <h3>hi, <span>admin</span></h3>
         <h1>welcome <span>@Session["admin_name"]</span></h1>
         <p>this is an admin page</p>
         <a href="loginForm.aspx" class="btn">login</a>
         <a href="registerForm.aspx" class="btn">register</a>
         <a href="logout.aspx" class="btn">logout</a>
      </div>
   </div>
</body>
</html>
