#!/usr/bin/perl

@verb=("move","store","discard");


@size=("small","medium","large");
@color=("red","yellow","green");
@shape=("triangle","arch","square");

@location=("pantry","dishwasher","garbage","table");

@prep=("to the left of","to the right of","in front of");


for($i=0;$i<12;$i++){
    $rSize = int(rand(3));
    $rColor = int(rand(3));
    $rShape = int(rand(3));
    $object = $size[$rSize] . " " . $color[$rColor] . " " . $shape[$rShape];

    @objects[$i]=$object;
    print $objects[$i] . "\n";
}

print "-------------------------------------------------------------\n";

for($i=0;$i<20;$i++){
    $vRand = int(rand(3));
    $verbDirectObject=$objects[int(rand(12))];
    
    if($vRand==0){
	$dice=int(rand(2));
	$preposition=@prep[int(rand(3))];
	$prepObject=$objects[int(rand(12))];
	$prepLocation=$location[int(rand(4))];
	if($dice==1){
	    print "move" . " " . "the " . $verbDirectObject . " " . $preposition . " " . "the " . $prepObject . "\n";
	}
	if($dice==0){
	    print "move" . " " . "the " . $verbDirectObject . " " . "in" . " " . "the " . $prepLocation . "\n";
	}
	    
    }
    else{
	$prepObject=$objects[int(rand(12))];
	print $verb[$vRand] . " " . "the " . $prepObject . "\n";
    }
    
}

