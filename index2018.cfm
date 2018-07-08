<cfparam name="hasMinutes" default="0">
<cfparam name="hasAgenda" default="0">
<cfparam name="hasDesc" default="0">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>City of Lomita - City Council Meetings</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../css/main_v4.css" rel="stylesheet" type="text/css">
<script language="Javascript" type="text/javascript" src="table.js"></script>
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
<!--- <cfset dir_query_path = #expandPath("./#dirName#/")# >
<cfoutput>dir_query_path: #dir_query_path#<br /></cfoutput> --->
<cfset regex = '[0-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'>
<cfset i = 1>
<cfset fileCount = 1>
<!--- loop through dirs inside main dir --->
<cfloop QUERY="dir_query">
<!--- 	<cfoutput>
	Current row tracking: #dir_query.Name[i]#<br />
	</cfoutput> --->
	<cfset MatchedDate = REFindNoCase(regex,dir_query.Name)>
<!--- 	<cfoutput><b>looping through</b> #dir_query.Name#<br /></cfoutput> --->
	<!--- if dir/filename matchs date format ---> 
	<cfif MatchedDate eq 1>
<!--- 		<cfoutput>Accepted Dir: #dir_query.Name#<br /></cfoutput> --->
		<!--- get filenames of contents of filtered dir --->
		<CFDIRECTORY ACTION="list" DIRECTORY="#expandPath("./#dirName#/#dir_query.Name#/")#" NAME="sub_dir_query" SORT="Name DESC">
		<!--- loop through that dir --->
		<cfloop query="sub_dir_query">
<!--- 				<cfoutput>current directory: #dir_query.Name[i]#<br /></cfoutput>	
				<cfoutput>current file: #sub_dir_query.Name#<br /></cfoutput> --->
			<cfset thisPath = "#expandPath("./#dirName#/#dir_query.Name#/")#">
<!--- 			<cfoutput>thisPath: #thisPath#<br /></cfoutput>  --->
			<!--- filter out .. and . entries in sub directories --->
			<cfif sub_dir_query.Name eq "." or sub_dir_query.Name eq "..">
				<cfset fileCount = fileCount + 1>
				<cfoutput>
<!--- 				fileCount: #fileCount#<br />
				recordCount: #sub_dir_query.recordcount#<br /> --->
				</cfoutput>
			<cfelse>
				<cfif Find("minutes",sub_dir_query.Name) EQ 1>
<!--- 					<cfoutput>minutes found<br /></cfoutput> --->
					<cfset hasMinutes = 1>
				</cfif>
				<cfif Find("agenda",sub_dir_query.Name) EQ 1>
<!--- 					<cfoutput>agenda found<br /></cfoutput> --->
					<cfset hasAgenda = 1>
				</cfif>
				<cfif Find("description",sub_dir_query.Name) EQ 1>
<!--- 					<cfoutput>desc found<br /></cfoutput> --->
					<cfset descPath = "#expandPath("./#dirName#/#dir_query.Name[i]#/description.txt")#">
<!--- 					<cfoutput>desc path: #descPath#<br /></cfoutput> --->
					<cffile action="read" file="#expandPath("./#dirName#/#dir_query.Name[i]#/description.txt")#" variable="descText">
<!--- 					<cfoutput>desc text: #descText#<br /></cfoutput> --->
					<cfset hasDesc = 1>
				</cfif>
			<!--- <cfoutput>
				hasMinutes: #hasMinutes#<br />
				hasDesc: #hasDesc#<br />
				hasAgenda: #hasAgenda#<br />
			</cfoutput> --->
<!--- 				<cfoutput>
				For meetingDate arg: #dir_query.Name#<br />
				and subdir arg: #dir_query.Name#<br />
				</cfoutput> --->
				<cfoutput>
<!--- 				fileCount: #fileCount#<br />
				recordCount: #sub_dir_query.recordcount#<br /> --->
				<!--- correct the file count to adjust for .. and . entries --->
				<cfset correctedCount = #sub_dir_query.recordcount# - 2>
				<cfif #fileCount# eq #correctedCount#>
<!--- 					fileCount equals rec count<br /> --->
					<cfif #hasAgenda# eq 1 and #hasMinutes# eq 1 and #hasDesc# eq 1>
<!--- 					<b>A M D triggered</b><br /> --->
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',2,2,'#dirName#/#dir_query.Name[i]#/','#descText#');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 1 and #hasMinutes# eq 0 and #hasDesc# eq 1>
<!--- 					<b>A D triggered</b><br /> --->
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',2,0,'#dirName#/#dir_query.Name[i]#/','#descText#');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 1 and #hasMinutes# eq 0 and #hasDesc# eq 0>
<!--- 					<b>A triggered</b><br /> --->
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',2,0,'#dirName#/#dir_query.Name[i]#/');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 0 and #hasMinutes# eq 1 and #hasDesc# eq 1>
<!--- 					<b>M D triggered</b><br /> --->
						<SCRIPT language=Javascript type=text/javascript>printRow('#dir_query.Name[i]#',0,2,'#dirName#/#dir_query.Name[i]#/','#descText#');</SCRIPT>
					</cfif>
					<cfif #hasAgenda# eq 0 and #hasMinutes# eq 1 and #hasDesc# eq 0>
<!--- 					<b>M triggered</b><br /> --->
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
