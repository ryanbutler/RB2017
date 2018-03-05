<%@ Page Title="Building and Deploying a ASP.NET (ASPX) website to production" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.produce_a_website_build_and_deploy.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Building and Deploying a ASP.NET (ASPX) website to production</h2>
<h3>Publishing production files to output path</h3>
<p>Since we have built our solution in release mode, and created a release profile, our last item is to publish our files to the correct output path. Follow these steps:</p>
<ol>
<li>Right click our solution from solution explorer and choose Publish:</li>
</ol>
<p class="alignCenter"><a href="images/publish.jpg" data-lightbox="Publish"><img src="thumbs/publish.jpg" alt="Publish" width="300" height="118" /></a></p>
<ol start="2">
<li>From the profile selection select the drop down list and select New Profile:</li>
</ol>
<p class="alignCenter"><a href="images/publish_profile_new.jpg" data-lightbox="Publish Profile New"><img src="thumbs/publish_profile_new.jpg" alt="Publish Profile New" width="300" height="53" /></a></p>
<ol start="3">
<li>In New Profile window type an appropriate release profile:</li>
</ol>
<p class="alignCenter"><a href="images/publish_type_name.jpg" data-lightbox="Publish Type Name"><img src="thumbs/publish_type_name.jpg" alt="Publish Type Name" width="300" height="119" /></a></p>
<ol start="4">
<li>From the connection selection, for Publish Method, choose File System:</li>
</ol>
<p class="alignCenter"><a href="images/publish_file_system.jpg" data-lightbox="Publish File System"><img src="thumbs/publish_file_system.jpg" alt="Publish File System" width="300" height="74" /></a></p>
<ol start="5">
<li>With Connection selected in target location, choose the appropriate release path:</li>
</ol>
<p class="alignCenter"><img src="images/publish_target_location.jpg" width="336" height="337" alt="Publish Target Location" /></p>
<ol start="6">
<li>
Select Settings and in File Publish Options, choose the following:
<ol type="a">
<li>Check Delete all existing files prior to publish</li>
</ol>
</li>
</ol>
<p class="alignCenter"><a href="images/publish_remove_existing_files.jpg" data-lightbox="Publish Remove Existing Files"><img src="thumbs/publish_remove_existing_files.jpg" alt="Publish Remove Existing Files" width="300" height="40" /></a></p>
<ol start="7">
<li>Left click Publish</li>
</ol>
<p>Visual Studio will open an output window at the bottom. If publishing succeeded we’ll see all the files necessary for publishing to a remote server for production:</p>
<p class="alignCenter"><a href="images/release_files.jpg" data-lightbox="Release Files"><img src="thumbs/release_files.jpg" alt="Publish Remove Existing Files" width="300" height="136" /></a></p>
<h3>Summary</h3>
<p>In this article we discussed how to separate development and production environments when creating and building solutions. We discussed a couple different branching options. Continuing we showed how to compile our solution in release mode and how to create a release publish profile to ensure only files needed for production make it to the desired release folder.</p>
<p>If you have questions, <a href="/contact.aspx">contact me</a>.</p>
</asp:Content>