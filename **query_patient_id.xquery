(:returns all incidents, medical records, ect with the same ID
id: patient status 
    medical history
    patient
    incident:)

declare function local:get_patient_status($stat , $id as xs:string) {
  for $patientStatus in $stat
  let $id_stat := $patientStatus/PatientStatus.patient/@id
  where $id_stat = $id
  let $nl := "&#10;"
  return 
    $patientStatus
  
};
declare function local:get_patient_medHistory($med , $id as xs:string) {
  for $medHistory in $med
  let $id_med := $medHistory/MedicalHistory.patient/@id
  where $id_med = $id
  let $nl := "&#10;"
  return 
     concat(
      "Medical Directives:", $nl,
      "DNR, Note: ", string-join($medHistory/MedicalHistory.medicalDirectives/data, ", "), $nl,
      "Insurance Info:", $nl,
      "Insurance provider, Insurance plan: ", string-join($medHistory/MedicalHistory.insuranceContactInfo/data, ", "),$nl,
      "Existing Conditions:", $nl,
       string-join($medHistory/MedicalHistory.existingConditions/data/@type, ", "), ": ", string-join($medHistory/MedicalHistory.existingConditions/data, ", "))
         
  
};
declare function local:get_patient($pat , $id as xs:string) {
  for $patient in $pat
  let $id_pat := $patient/@id
  where $id_pat = $id
  let $nl := "&#10;"
  return
    concat(
      "Patient id: ", $patient/@id, $nl, 
      "Name: ", $patient/Patient.name, $nl, 
      "Date of birth: ", $patient/Patient.dob, $nl, 
      "Gender: ", $patient/@gender, $nl, 
      "PPSN: ", $patient/@ppsn, $nl,
      "Blood type: ", $patient/@bloodType, $nl        
    )   
};
declare function local:get_patient_incident($inc , $id as xs:string) {
  for $incident in $inc
  let $id_inc := $incident/Incident.patientID/@id
  where $id_inc = $id
  let $nl := "&#10;"
  return 
    concat(
      $nl, "Incident Information ", $nl,
        "Incident ID: ", $incident/@id, $nl,
        "Severity: ", $incident/Incident.category/@severity, $nl,
        "Location: ", $incident/Incident.location, $nl,
        "Date: ", $incident/Incident.date, $nl,
        "Time of FR arrival: ", $incident/Incident.timeOfArrival, $nl,
        "Context of incident: ", $incident/Incident.context, $nl)
  
};

let $id := "WK385"
let $status := doc("PatientStatus.xml")/PatientStatuses/PatientStatus
let $medHistory := doc("Patient.xml")/Patients/Patient/Patient.MedicalHistory/MedicalHistory
let $patient := doc("Patient.xml")/Patients/Patient
let $incident := doc("Incidents.xml")/Incidents/Incident

return (local:get_patient($patient, $id),
local:get_patient_status($status, $id),
local:get_patient_medHistory($medHistory, $id),
local:get_patient_incident($incident, $id))
