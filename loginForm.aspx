<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginForm.aspx.cs" Inherits="final_exam.loginForm" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login Form</title>

    <!-- Custom CSS file link -->
    <link rel="stylesheet" href="AdminStyle.css" />
</head>
<body>
    <div class="form-container">
        <form runat="server" method="post">
            <h3>Login Now</h3>
            <asp:Literal ID="errorLiteral" runat="server" />
            <input type="email" name="email" runat="server" required placeholder="Enter your email" />
            <input type="password" name="password" runat="server" required placeholder="Enter your password" />
            <input type="submit" name="submit" value="Login Now" class="form-btn" runat="server" onserverclick="Submit_Click" />
            <p>Don't have an account? <a href="registerForm.aspx">Register now</a></p>
        </form>
    </div>
</body>
</html>

<script runat="server">
    void Submit_Click(object sender, EventArgs e)
    {
        string email = email.Value;
        string password = password.Value;

        string hashedPassword = MD5(password);

        SqlConnection conn = null;
        SqlCommand cmd = null;
        SqlDataReader reader = null;

        try
        {
            conn = new SqlConnection("Data Source=localhost;Initial Catalog=user_db;User ID=root;Password=");
            conn.Open();

            string selectQuery = "SELECT * FROM user_form WHERE email = @Email AND password = @Password";
            cmd = new SqlCommand(selectQuery, conn);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", hashedPassword);

            reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                string userType = reader["user_type"].ToString();

                if ("admin".Equals(userType))
                {
                    Session["admin_name"] = reader["name"].ToString();
                    Response.Redirect("adminPage.aspx");
                }
                else if ("user".Equals(userType))
                {
                    Session["user_name"] = reader["name"].ToString();
                    Response.Redirect("userPage.aspx");
                }
            }
            else
            {
                errorLiteral.Text = "<span class='error-msg'>Incorrect email or password!</span>";
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
        finally
        {
            if (reader != null) reader.Close();
            if (cmd != null) cmd.Dispose();
            if (conn != null) conn.Close();
        }
    }

    string MD5(string input)
    {
        using (MD5 md5 = MD5.Create())
        {
            byte[] data = md5.ComputeHash(System.Text.Encoding.UTF8.GetBytes(input));
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sb.Append(data[i].ToString("x2"));
            }
            return sb.ToString();
        }
    }
</script>
