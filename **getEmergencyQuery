declare function local:print($inc as element(Incident)){
 if ($inc/Incident.category/@severity = "high" or $inc/Incident.category/@severity = "critical")
    then $inc
    else ()
  };

for $x in doc("Incidents.xml")/Incidents/Incident
return local:print($x)




