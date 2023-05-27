<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Client.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="Text" runat="server"></asp:TextBox>
            <asp:TextBox ID="result" runat="server"></asp:TextBox>
            <asp:Button ID="button" runat="server" OnClick="button_Click" />
        </div>
    </form>
</body>
</html>
