(:if the location of a notification and the location of a notification match, it returns the incident :)

let $notification := doc("Notification.xml")/Notifications/Notification
let $reporterLocation := $notification/Notification.reporterLocation

for $incident in doc("Incidents.xml")/Incidents/Incident
where $incident/Incident.location = $reporterLocation
return $incident
