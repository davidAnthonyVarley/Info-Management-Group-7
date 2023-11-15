(: Method 1, display all police database incidents:)


<IncidentsInPoliceDB> 
{
   for $i in doc("Police.xml")/Police/Police.policeDatabase/Incident/Incident.context
  return
    $i
}
    
</IncidentsInPoliceDB>