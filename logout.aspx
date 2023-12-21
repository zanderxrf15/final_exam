<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="final_exam.logout" %>

<!DOCTYPE html>

<%
    string path = Server.MapPath("~/WEB-INF/config.aspx");
    Server.Execute(path);

    Session.Abandon();

    Response.Redirect("loginForm.aspx");
%>

