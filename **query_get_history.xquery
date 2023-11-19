(:returns medical history of a patient based on its ID:)

declare function local:get_from_history($id as xs:string) {
  for $history in doc("Patient.xml")/Patients/Patient/Patient.MedicalHistory/MedicalHistory
  let $id_history := $history/MedicalHistory.patient/@id
  where $id_history = $id
  return $history
}; 

declare function local:get_from_database($id as xs:string) {
  for $history in doc("Patient.xml")/Patients/Patient/Patient.HSEDataBase/HSEDataBase/HSEDatabase.medicalHistoryOfPatients/medicalHistoryOfPatients.MedicalHistory/MedicalHistory
  let $id_history := $history/MedicalHistory.patient/@id
  where $id_history = $id
  return $history
}; 

  let $id := "WK385"
  return (local:get_from_history($id), local:get_from_database($id))

  
