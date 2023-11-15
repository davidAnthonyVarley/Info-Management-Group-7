declare function local:find_matching_blood_types($type as xs:string) {
  
  for $p in doc("Patients.xml")//Patient
  where [$type = $p/Patient.bloodType]
  union
  where [$p/Patient.PatientStatus[@alive="true"]]
  return 
  <patient_with_matching_blood_type>
    {$p//name}
    {$p//ppsn}
    
  </patient_with_matching_blood_type>
};

<Viable_patients> 
{
  let $type := "A+"
  return
  local:find_matching_blood_types($type)
}
  
</Viable_patients>
