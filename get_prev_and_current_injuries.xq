(: get current injuries, previous injuries and medical directives also if you want?? :)

declare function local:get_existing_conditions($patient as element(Patient)) {
 
 
 for $i in $patient/Patient.MedicalHistory/MedicalHistory.existingConditions[@type="array"]
 return 
 <previous_conditions> 
  
  
  {string($i)}
  </previous_conditions>

};

declare function local:get_current_injuries($PS as element(PatientStatus)) {
  for $current in $PS/PatientStatus.injuries[@type="array"]
  where exists(doc("Patient.xml")/Patients/Patient/Patient.PatientStatus)
  return 
  <current_injury> 
    {string($current)}
  </current_injury>
};





for $index in 1 to 3

let $ps := doc("PatientStatus.xml")/PatientStatuses/PatientStatus[$index]
let $p := doc("Patient.xml")/Patients/Patient[$index]

return
<p>

  { local:get_existing_conditions($p)}
  { local:get_current_injuries($ps ) }
  
  
</p>