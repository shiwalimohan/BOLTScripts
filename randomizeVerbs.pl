#!/usr/bin/perl

@verb=("move","move-left","move-right");
@object=(1,2,3,4);
@location=("pantry","dishwasher","garbage","table");
@situation=("empty","correct");
@instruction=("direct","indirect");


for($i=0;$i<3;$i++){
    print $verb[$i] . " ". $object[int(rand(4))] . " ". $location[int(rand(4))] . " " . $situation[int(rand(2))] . " " . $instruction[int(rand(2))] . "\n";
}
@verb=("discard");
@location=("garbage");
    print $verb[0] . " ". $object[int(rand(4))] . " " . $situation[int(rand(2))] . " " . $instruction[int(rand(2))] . "\n";

@verb=("store");
@location=("pantry");
    print $verb[0] . " ". $object[int(rand(4))] . " " . $situation[int(rand(2))] . " " . $instruction[int(rand(2))] . "\n";
