
<IncidentsInPoliceDB> {
for $x in doc("Police.xml")/Police/Police.policeDatabase/Incident
where $x/Incident.category/@severity = "high" or $x/Incident.category/@severity = "critical"
return $x
}
</IncidentsInPoliceDB>