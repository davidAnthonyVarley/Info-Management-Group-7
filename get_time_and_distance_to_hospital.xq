(: xQuery not finished, template :)

declare function local:get_time_until_dest_mins($locations as element(Locations)) {

    for $time in doc("Locations.xml")/Locations/location
    return $time/timeUntilDestMins
}

declare function local:get_dist_to_dest_kms($locations as element(Locations)) {

    for $distance in doc("Locations.xml")/Locations/location
    return $distance/distToDestKms
}

declare function local:get_traffic_level($locations as element(Locations)){

    for $traffic in doc("Locations.xml")/Locations/location
    return $traffic/trafficLevel
}
