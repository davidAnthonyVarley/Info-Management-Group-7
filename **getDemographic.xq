(: method 6, get patient details (for hospital or police to use) :)

declare function local:get_age_as_int($dob as element(Patient.dob)) {
  
  let $content := string($dob)
  let $length := string-length($content)
  
  (: using length -3 because for some quirky reason xquery uses 1-based indexing:)
  let $year := substring($content, $length - 3)
  
  let $num := xs:integer($year)
  let $age := (year-from-dateTime(current-dateTime()) ) - $num
  
  return $age
  
};

declare function local:get_age_as_string($dob as element(Patient.dob)) {
  let $age := xs:string(local:get_age_as_int($dob))
  return xs:string($age)
};


declare function local:get_demographic($p as element(Patient)) {
  
  let $age as xs:integer := local:get_age_as_int($p/Patient.dob)
  
  let $result :=
  if ($age < 18) then
    "Minor"
  else if ($age > 64 ) then
    "OAP"
  else 
    "Adult"
    
  return $result
  
};

for $p in doc("Patient.xml")/Patients/Patient
return
<Patient_Details> 

  <name> { string($p/Patient.name)} </name>
  <age> { local:get_age_as_string($p/Patient.dob) }</age>
  <demographic> { local:get_demographic($p) } </demographic>
  
 </Patient_Details>

