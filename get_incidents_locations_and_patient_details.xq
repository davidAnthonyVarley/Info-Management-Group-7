(: method 5, get the location of an incident, then gets the name and existing conditions of a patient

    QUESTION:
    can we add incidentLocation to Patient class?
    because then this class will have 
     1 WHERE clause,  1 FOR clause, 1 LET clause, 2 Built-in XQuery function and 1 User Defined Function
    :)
declare function local:get_locations_of_incident($number as xs:integer) {
  
  
  let $loc := doc("Location.xml")/Locations/Location[$number]
  where exists($loc)
  return
  <Location_of_Incident>
    <current_location> {$loc/string(Location.currentLocation) }</current_location>
    <encryption_key> {$loc/Location.Encryptor/Location.Encryptor.key/string(@encryptionKey) }</encryption_key>
    <reference_to_encryption_data> {$loc/Location.Encryptor/Location.Encryptor.dataToEncrypt /string(@referenceToData) } </reference_to_encryption_data>
    
  </Location_of_Incident> 
};

for $patient in doc("Patient.xml")//Patient
return 
<Incident_Details>
  <name> { $patient/string(Patient.name)}</name>
  <existing_conditions> { $patient/Patient.medicalHistory/string(medicalHistory.existingConditinons)}</existing_conditions>
  { local:get_locations_of_incident($patient) }

</Incident_Details>

