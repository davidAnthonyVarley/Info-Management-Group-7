(:get all alive patients and their name + injuries:)

declare function local:get_patient_injuries($pat as element(Patient)) {
  let $patientName := $pat/Patient.name/text()
  for $inj in $pat/Patient.PatientStatus/PatientStatus/PatientStatus.injuries
  return 
  concat("Patient Name: ", $patientName, ", Injuries: ", string-join($inj, ", "))
}; 

for $p in doc("Patient.xml")/Patients/Patient
where ($p/Patient.PatientStatus/PatientStatus[@alive="true"])
return 
  local:get_patient_injuries($p)
