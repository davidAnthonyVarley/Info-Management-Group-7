(:given a location, it return the incident and the patient:)
declare function local:get_incident($coordinates as xs:string) {
  for $inc in doc("Incidents.xml")/Incidents/Incident
  let $loc_inc := $inc/Incident.location/text()
  where $loc_inc = $coordinates
  return $inc
};

declare function local:get_patient_info($incident) {
  let $id := $incident/Incident.patientID/@id
  for $pat in doc("Patient.xml")/Patients/Patient
  let $pat_id := $pat/@id
  where $pat_id = $id
  return (
      "Patient:", <Patient>{$pat/@id}</Patient>,
        $pat/Patient.name,
        $pat/Patient.dob,
         <Patient>{$pat/@gender}</Patient>,
      <Patient>{$pat/@ppsn}</Patient>,
      <Patient>{$pat/@bloodType}</Patient>,
      $pat/Patient.MedicalHistory/MedicalHistory             
    )   

  
};
let $location := "51.878748, -8.532065"
let $inc := local:get_incident($location)
return (local:get_patient_info($inc),$inc)
