(:given coordinates, it returns the km to the hospital, how long it will take and the traffic level :)


declare function local:getLocationInfo($locations as element(Locations), $currentLocation as xs:string) as xs:string {
 let $location := $locations/Location[Location.currentLocation/text() = $currentLocation]
  return
    if (empty($location)) then
      "Location not found."
    else
  let $timeUntilDestMins := $location/Location.timeUntilDestMins/text()
  let $distToDestKms := $location/Location.distToDestKms/text()
  let $trafficLevel := $location/Location.trafficLevel/@level

  return
    concat(
      "Distance to Hospital: ", $distToDestKms, " km",
      ", Time until Destination: ", $timeUntilDestMins, " mins",
      ", Traffic Level: ", $trafficLevel
    )
};

let $currentLocation := "53.16528,-7.237383" (: Replace with the actual current location :)

for $locations in doc("Locations.xml")/Locations
return
  local:getLocationInfo($locations, $currentLocation)

