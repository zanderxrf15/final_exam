<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registerForm.aspx.cs" Inherits="final_exam.registerForm" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    public string MD5(string input)
    {
        using (MD5 md5 = MD5.Create())
        {
            byte[] inputBytes = Encoding.UTF8.GetBytes(input);
            byte[] hashBytes = md5.ComputeHash(inputBytes);
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < hashBytes.Length; i++)
            {
                sb.Append(hashBytes[i].ToString("x2"));
            }

            return sb.ToString();
        }
    }

    SqlConnection conn = null;
    try
    {
        string connectionString = "Data Source=localhost;Initial Catalog=user_db;User ID=root;Password=";
        conn = new SqlConnection(connectionString);
        conn.Open();
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }

    if (conn == null)
    {
        Response.Write("Failed to make connection to the database.");
    }
    else
    {
        if (Request.Form["submit"] != null)
        {
            string name = Request.Form["name"];
            string email = Request.Form["email"];
            string password = MD5(Request.Form["password"]);
            string cpassword = MD5(Request.Form["cpassword"]);
            string user_type = Request.Form["user_type"];

            string selectQuery = "SELECT * FROM user_form WHERE email = @Email AND password = @Password";
            try
            {
                using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Response.Write("User already exists!");
                    }
                    else
                    {
                        if (password.Equals(cpassword))
                        {
                            string insertQuery = "INSERT INTO user_form(name, email, password, user_type) VALUES (@Name, @Email, @Password, @UserType)";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@Name", name);
                                insertCmd.Parameters.AddWithValue("@Email", email);
                                insertCmd.Parameters.AddWithValue("@Password", password);
                                insertCmd.Parameters.AddWithValue("@UserType", user_type);
                                insertCmd.ExecuteNonQuery();
                                Response.Redirect("loginForm.aspx");
                            }
                        }
                        else
                        {
                            Response.Write("Password not matched!");
                        }
                    }
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>register form</title>

    <!-- custom css file link  -->
    <link rel="stylesheet" href="AdminStyle.css">
</head>
<body>
<div class="form-container">
    <form action="" method="post">
        <h3>register now</h3>
        <% if (Response.BufferOutput) { %>
            <span class="error-msg"><%= Response.Output.ToString() %></span>
        <% } %>
        <input type="text" name="name" required placeholder="enter your name">
        <input type="email" name="email" required placeholder="enter your email">
        <input type="password" name="password" required placeholder="enter your password">
        <input type="password" name="cpassword" required placeholder="confirm your password">
        <select name="user_type">
            <option value="user">user</option>
            <option value="admin">admin</option>
        </select>
        <input type="submit" name="submit" value="register now" class="form-btn">
        <p>already have an account? <a href="loginForm.aspx">login now</a></p>
    </form>
</div>
</body>
</html>

