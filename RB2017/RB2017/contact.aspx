<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="RB2017.Contact" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $("#contact").addClass("contact");
</script>
<h2>Contact Me</h2>
<asp:PlaceHolder ID="formPH" runat="server" Visible="true">
<form runat="server">
<asp:ValidationSummary ID="vsErrorMessages" runat="server" DisplayMode="BulletList" ShowMessageBox="false" ShowSummary="true" ForeColor="Red" Font-Size="Medium"/>
<table>
<tr>
<td>First Name:</td>
<td><asp:TextBox ID="FNameTB" runat="server"/>
<asp:RequiredFieldValidator ID="rfvFName" ControlToValidate="FNameTB" runat="server" ErrorMessage="First Name is required." Display="None" />
</td>
</tr>
<tr>
<td>Last Name:</td>
<td><asp:TextBox ID="LNameTB" runat="server" />
<asp:RequiredFieldValidator ID="rfvLName" ControlToValidate="LNameTB" runat="server" ErrorMessage="Last Name is required." Display="None"/>
</td>
</tr>
<tr>
<td>Email:</td>
<td><asp:TextBox ID="EmailTB" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="EmailTB" runat="server" ErrorMessage="Email is required." Display="None" />
<asp:Label ID="invalidEmailFormat" runat="server" Visible="false" ForeColor="Red" Font-Size="Medium" Text="Invalid email format" />
</td>
</tr>
<tr>
<td>Article Question?</td>
<td><asp:RadioButton ID="radArticleQuestionYes" runat="server" Text="Yes"/>
<asp:RadioButton ID="radArticleQuestionNo" runat="server" Text="No"/>
</td>
</tr>
<tr>
<td>Which article?</td>
<td><asp:DropDownList ID="ddlWhichArticle" runat="server" />
<asp:RequiredFieldValidator ID="rfvWhichArticle" runat="server" ControlToValidate="ddlWhichArticle" InitialValue="1" ErrorMessage="Which article selection is required." Display="None"/>
</td>
</tr>
<tr>
<td>Question/comments:</td>
<td><asp:TextBox ID="CommentsTB" runat="server" TextMode="MultiLine" Rows="5" Columns="20"/>
<asp:RequiredFieldValidator ID="rfvComments" runat="server" ControlToValidate="CommentsTB" ErrorMessage="Question or Comments is required." Display="None" />
</td>
</tr>
<tr>
<td colspan="2"><asp:Button ID="btnSubmit" OnClick="Send_Mail" runat="server" Text="Submit" />
<asp:Button ID="btnReset" OnClientClick="this.form.reset();return false;" runat="server" Text="Reset" /></td>
</tr>
</table>
</form>
</asp:PlaceHolder>
<asp:PlaceHolder ID="successPH" runat="server" Visible="false">
<p>Thank you for your submission.</p>
</asp:PlaceHolder>
</asp:Content>