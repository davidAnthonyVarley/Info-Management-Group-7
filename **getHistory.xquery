(:returns medical history of a patient based on its ID:)

declare function local:get_from_history($id as xs:string) {
  let $nl := "&#10;"
  for $history in doc("Patient.xml")/Patients/Patient/Patient.MedicalHistory/MedicalHistory
  let $id_history := $history/MedicalHistory.patient/@id
  where $id_history = $id
  
  return 
    concat(
      "Patient ID: ", $history/MedicalHistory.patient/@id, $nl,
      "Medical Directives:", $nl,
      "   DNR, Note: ", string-join($history/MedicalHistory.medicalDirectives/data, ", "), $nl,
      "Insurance Info:", $nl,
      "   Insurance provider, Insurance plan: ", string-join($history/MedicalHistory.insuranceContactInfo/data, ", "),$nl,
      "Existing Conditions:", $nl,
      "   ", string-join($history/MedicalHistory.existingConditions/data/@type, ", "), ": ", string-join($history/MedicalHistory.existingConditions/data, ", "))
}; 

declare function local:get_from_database($id as xs:string) {
  for $history in doc("Patient.xml")/Patients/Patient/Patient.HSEDataBase/HSEDataBase/HSEDatabase.medicalHistoryOfPatients/medicalHistoryOfPatients.MedicalHistory/MedicalHistory
  let $id_history := $history/MedicalHistory.patient/@id
  where $id_history = $id
  return $history
}; 

  let $id := "WK385"
  return (local:get_from_history($id), local:get_from_database($id))


  
