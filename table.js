/* printRow options

   0::none 1::html 2::pdf 3::annotated agenda

    0  1    '-'               minutes.html
    0  2    '-'               minutes.pdf

    1  0    agenda.html       '-'
    1  1    agenda.html       minutes.html
    1  2    agenda.html       minutes.pdf

    2  0    agenda.pdf        '-'
    2  1    agenda.pdf        minutes.html
    2  2    agenda.pdf        minutes.pdf

    3  0    agenda.pdf        '-'               (annotated)                  
    3  1    agenda.pdf        minutes.html
    3  2    agenda.pdf        minutes.pdf
*/

var d = document;
function printHeader(){
	// print title and tabs along top of page - one tab for each year
	d.writeln("<span style='font-size:14px;color:black;text-align:left;line-height:18px;font-weight:bold;'>LOMITA CITY COUNCIL AGENDAS AND MINUTES<br>" + thisYear + "</span>");
	d.writeln("<p>Beginning with the February 6, 2012 meeting, staff reports (in pdf format) are available by clicking on the individual hyperlink in the agenda document.</p><br>");
	d.writeln("<TABLE border=0 cellspacing=0 cellpadding=0 align=left style='margin-left:15px;'>");
	d.writeln("<TR><TD width=15%></TD><TD width=15%></TD><TD width=15%></TD><TD></TD></TR>");
	d.writeln("<TR><TD colspan=4>");
	d.writeln("<div id='tabs' style='margin: 0 0 0 10px ; width:100%;'><ul>");
	
	for ( var Y=2018;Y>=1998;Y--) {
		if (Y == 2018) {d.writeln("<li><A href='index2018.cfm'>2018</A></li>");}
		else {d.writeln("<li><A href='index"+Y+".html'>" + Y + "</A></li>");}
	}
/*	d.writeln("<li><A href='ccindex.html' style='font-variant:small-caps;'>All</A></li>"); */
	d.writeln("</ul></div></TD></TR>");
	d.writeln("<TR id=cardheader>");
	d.writeln("<TD style='padding: 2px 0 2px' align=center>MEETING<br>DATE</TD>");
	d.writeln("	<TD style='padding: 2px 0 2px;' align=center colspan=2>DOCUMENTS</TD>");
	d.writeln("	<TD>&nbsp;</TD>");
	d.writeln("</TR>");
	return true;
}

function printRow(meetingDate,agendaCode,minutesCode,description) {
   // display first 10 characters from meetingDate in column 1:  2011-03-15
   // because special meetings have 'sp' in meetingDate field:  2011-03-15sp
   d.write("<tr><td align=center style='line-height:18px;'>" + meetingDate.substring(0,10) + "</td>");

   switch(agendaCode) {
      case 0:  d.write("<TD align=center>-</TD>"); break;
      case 1:  d.write("<TD align=center><a href='agenda_" + meetingDate + ".html' target='_blank'>Agenda</A></TD>"); break;
      // annotated agendas(3) are always in pdf, so agenda codes 2 & 3 print the same...
      case 2:
      case 3:  d.write("<TD align=center><a href='agenda_" + meetingDate + ".pdf' target='_blank'>Agenda</A></TD>"); break;
   }

   switch(minutesCode) {
      case 0:  d.write("<TD align=center>-</TD>"); break;
      case 1:  d.write("<TD align=center><a href='minutes_" + meetingDate + ".html' target='_blank'>Minutes</A></TD>"); break;
      case 2:  d.write("<TD align=center><a href='minutes_" + meetingDate + ".pdf' target='_blank'>Minutes</A></TD>"); break;
   }
   // if description is defined, print it here, otherwise a blank cell.
   if ( description ) d.write("<TD align=left>(" + description + ")</TD>"); else d.write("<TD>&nbsp;</TD>");

   d.writeln("</TR>");
   ++rowCount;
   return true;
}

// print years from current back to 1998.
// current year is specified as argument -  bolded.  
// all other years reference links to indexYYYY.html

function printYears(y) {  // obsolete function
	d.write("<table border='0'><tr><td width='80pt'><b>Archives</b></td>\n");
	for ( var i=2016; i>=1998; i-- ) {
		if ( i == y ) {
			d.write("<td width='40pt' style='text-align:center; font-family: Arial, Helvetica, sans-serif; font-weight:bold;' >");
			d.write( i + "</td>\n");
		} else {
			d.write("<td width='40pt' style='text-align:center; font-family: Arial, Helvetica, sans-serif; font-weight:normal'>");
			d.write("<a href=\"index" + i + ".html\">" + i + "</a></td>\n");
		}
	}
	d.write("<td width='40pt' style='text-align:center;font-family: Arial, Helvetica, sans-serif; font-weight:normal'>");
			d.write("<a href='ccindex.html'>&nbsp;ALL&nbsp;</a></td>\n");

	d.writeln("</tr></table><br>");
	return true;
}

function printTail(){ 
	// print extra blank lines up to 25 before printing final HR.
	// some years already exceed 25 entries so no action taken
	d.writeln("</TD></TR>");
	for (var i=rowCount; i<25;i++) 	d.writeln("<TR><TD colspan=4>&nbsp;</TD></TR>");
	d.writeln("<TR><TD colspan=4>&nbsp;</TD></TR>");
	d.writeln("</TABLE>");
}
