(:given a location, it return the incident and the patient:)
declare function local:get_incident($coordinates as xs:string) {
  let $nl := "&#10;"
  for $inc in doc("Incidents.xml")/Incidents/Incident
  let $loc_inc := $inc/Incident.location/text()
  where $loc_inc = $coordinates
  return $inc
};

declare function local:print_incident($inc) {
  let $nl := "&#10;"
  return concat(
      $nl, "Incident information: ", $nl,
        "Incident ID: ", $inc/@id, $nl,
        "Severity: ", $inc/Incident.category/@severity, $nl,
        "Location: ", $inc/Incident.location, $nl,
        "Date: ", $inc/Incident.date, $nl,
        "Time of FR arrival: ", $inc/Incident.timeOfArrival, $nl,
        "Context of incident", $inc/Incident.context, $nl)
};

declare function local:get_patient_info($incident) {
  let $nl := "&#10;"
  let $id := $incident/Incident.patientID/@id  
  for $pat in doc("Patient.xml")/Patients/Patient
  let $history := $pat/Patient.MedicalHistory/MedicalHistory 
  let $pat_id := $pat/@id
  where $pat_id = $id
  return (
      concat("Patient ID:", $pat/@id, $nl,
        "Name: ", $pat/Patient.name, $nl,
        "DOB: ", $pat/Patient.dob, $nl,
        "Gender: ", $pat/@gender, $nl,
        "PPSN: ", $pat/@ppsn, $nl,
        "Blood Type", $pat/@bloodType, $nl),
      concat(
      "Medical Directives:", $nl,
      "   DNR, Note: ", string-join($history/MedicalHistory.medicalDirectives/data, ", "), $nl,
      "Insurance Info:", $nl,
      "   Insurance provider, Insurance plan: ", string-join($history/MedicalHistory.insuranceContactInfo/data, ", "),$nl,
      "Existing Conditions:", $nl,
      "   ", string-join($history/MedicalHistory.existingConditions/data/@type, ", "), ": ", string-join($history/MedicalHistory.existingConditions/data, ", "))
      )   

  
};
let $location := "51.878748, -8.532065"
let $inc := local:get_incident($location)
return (local:get_patient_info($inc),local:print_incident($inc))
