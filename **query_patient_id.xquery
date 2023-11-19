(:returns all incidents, medical records, ect with the same ID
id: patient status 
    medical history
    patient
    incident:)

declare function local:get_patient_status($stat , $id as xs:string) {
  for $patientStatus in $stat
  let $id_stat := $patientStatus/PatientStatus.patient/@id
  where $id_stat = $id
  return $patientStatus
  
};
declare function local:get_patient_medHistory($med , $id as xs:string) {
  for $medHistory in $med
  let $id_med := $medHistory/MedicalHistory.patient/@id
  where $id_med = $id
  return $medHistory
  
};
declare function local:get_patient($pat , $id as xs:string) {
  for $patient in $pat
  let $id_pat := $patient/@id
  where $id_pat = $id
  return
    concat(
      "Patient id: ", $patient/@id,
      ", Name: ", $patient/Patient.name,
      ", Date of birth: ", $patient/Patient.dob,
      ", Gender: ", $patient/@gender,
      ", PPSN: ", $patient/@ppsn,
      ", Blood type: ", $patient/@bloodType             
    )   
};
declare function local:get_patient_incident($inc , $id as xs:string) {
  for $incident in $inc
  let $id_inc := $incident/Incident.patientID/@id
  where $id_inc = $id
  return $incident
  
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
