<cfparam name="hasMinutes" default="0">
<cfparam name="hasAgenda" default="0">
<cfparam name="hasDesc" default="0">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>City of Lomita - City Council Meetings</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../css/main_v4.css" rel="stylesheet" type="text/css">
<script language="Javascript" type="text/javascript" src="table2018.js"></script>
<style type="text/css">
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}
</style>
<style type="text/css">
@import url("agendamin.css");
</style>
</head>
<body>
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" summary="Layout Table">
<tr>
<td></td>
<td valign="top" id="main" width="100%">
<SCRIPT language=Javascript type=text/javascript>
// =========================================================================================
	var thisYear = 2018;
	var rowCount = 0;
	printHeader();
</SCRIPT>
<!--- set main directory --->
<cfset dirName = "2018">
<!--- get directories inside main dir --->
<CFDIRECTORY ACTION="list" DIRECTORY="#expandPath("./#dirName#/")#" NAME="dir_query" SORT="Name DESC">
<cfset regex = '[0-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'>
<cfset i = 1>
<cfset fileCount = 1>
<!--- loop through dirs inside main dir --->
<cfloop QUERY="dir_query">
	<cfset MatchedDate = REFindNoCase(regex,dir_query.Name)>
	<!--- if dir/filename matches date format ---> 
	<cfif MatchedDate eq 1>
		<!--- get filenames of contents of filtered dir --->
		<CFDIRECTORY ACTION="list" DIRECTORY="#expandPath("./#dirName#/#dir_query.Name#/")#" NAME="sub_dir_query" SORT="Name DESC">
		<!--- loop through that dir --->
		<cfloop query="sub_dir_query">
			<cfset thisPath = "#expandPath("./#dirName#/#dir_query.Name#/")#">
			<!--- filter out .. and . entries in sub directories --->
			<cfif sub_dir_query.Name eq "." or sub_dir_query.Name eq "..">
				<!--- though .. and . aren't files, cfdir counts them as such, so increment --->
				<cfset fileCount = fileCount + 1>
			<cfelse>
				<cfif Find("minutes",sub_dir_query.Name) EQ 1>
					<cfset hasMinutes = 1>
				</cfif>
				<cfif Find("agenda",sub_dir_query.Name) EQ 1>
					<cfset hasAgenda = 1>
				</cfif>
				<cfif Find("description",sub_dir_query.Name) EQ 1>
					<cfset descPath = "#expandPath("./#dirName#/#dir_query.Name[i]#/description.txt")#">
					<cffile action="read" file="#expandPath("./#dirName#/#dir_query.Name[i]#/description.txt")#" variable="descText">
					<cfset hasDesc = 1>
				</cfif>
				<cfoutput>
				<!--- correct the file count to adjust for .. and . entries --->
				<cfset correctedCount = #sub_dir_query.recordcount# - 2>
				<cfif #fileCount# eq #correctedCount#>
					<!--- if we've reached the end of the files in the dir, check vars to output javascript  --->
					<cfif #hasAgenda# eq 1 and #hasMinutes# eq 1 and #hasDesc# eq 1>
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',2,2,'#dirName#/#dir_query.Name[i]#/','#descText#');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 1 and #hasMinutes# eq 1 and #hasDesc# eq 0>
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',2,2,'#dirName#/#dir_query.Name[i]#/');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 1 and #hasMinutes# eq 0 and #hasDesc# eq 1>
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',2,0,'#dirName#/#dir_query.Name[i]#/','#descText#');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 1 and #hasMinutes# eq 0 and #hasDesc# eq 0>
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',2,0,'#dirName#/#dir_query.Name[i]#/');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 0 and #hasMinutes# eq 1 and #hasDesc# eq 1>
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',0,2,'#dirName#/#dir_query.Name[i]#/','#descText#');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 0 and #hasMinutes# eq 1 and #hasDesc# eq 0>
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',0,2,'#dirName#/#dir_query.Name[i]#/');</SCRIPT>
					</cfif>
				</cfif>
				</cfoutput>
				<cfset fileCount = fileCount + 1>
			</cfif>
		</cfloop>
	</cfif>
	<cfset fileCount = 1>
	<cfset hasAgenda = 0>
	<cfset hasMinutes = 0>
	<cfset hasDesc = 0>
	<cfset i = i + 1>
</cfloop>
</td>
</tr>
</table>
</body>
</html>
