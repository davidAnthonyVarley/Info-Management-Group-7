(: method 2, get all alive patients and their name + injuries:)


declare function local:get_patient_injuries($pat as element(Patient)) {
 
  <Patient>
  {string($pat/name)}
  for $inj in $pat/Patient.PatientStatus//PatientStatus.injuries
  return 
  $inj
  </Patient>
  
};

<alive_patients>
{

for $p in doc("Patient.xml")/Patients/Patient

where ($p/Patient.PatientStatus[@alive="true"])
return 


  <name>  {$p/Patient.name/string()} </name>
}
</alive_patients>


