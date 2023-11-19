declare function local:print($inc as element(Incident)) as xs:string {
 let $severity := $inc/Incident.category[@severity = "high" or @severity = "critical"]
  return
    if (empty($inc)) then
      "No bad accidents found"
    else
      let $severity := $inc/Incident.category/@severity
      let $report := $inc/@reportToPolice
      let $date := $inc/Incident.date/text()
      let $location := $inc/Incident.location/text()
      let $timeArr := $inc/Incident.timeOfArrival/text()
      let $context := $inc/Incident.context/text()

      return
        concat(
        "INCIDENT DETAILS:",
        "Severity: ", $severity,
        ", Reported to police: ", $report, 
        ", Date: ", $date,
        ", Location: ", $location,
        ", Time of arrival: ", $timeArr,
        ", Context of the incident: ", $context
    )
};

for $x in doc("Police.xml")/Police/Police.policeDatabase/Incident
return local:print($x)

(:where $x/Incident.category/@severity = "high" or $x/Incident.category/@severity = "critical"
return $x :)
