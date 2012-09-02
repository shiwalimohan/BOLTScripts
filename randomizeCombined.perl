#!/usr/bin/perl


#### ./randomizeCombined.perl <number of objects> <number of verb commands in one trial> <number of trials>


@verb=("move","store","discard","move","move");
$verbLength=@verb;

@size=("small","medium","large");
$sizeLength=@size;

@color=("red","yellow","green");
$colorLength=@color;

@shape=("triangle","arch","square","rectangle");
$shapeLength=@shape;

@location=("pantry","dishwasher","garbage","table");
$locationLength=@location;

@prep=("to the left of","to the right of","in front of");
$prepLength=@prep;


$objectSelectionLength=$ARGV[0];
$commandLength=$ARGV[1];
$trialLength=$ARGV[2];

$move = "move";
$store = "store";
$discard = "discard";


print "# Objects for the run are\n";
for($i=0;$i<$objectSelectionLength;$i++){
    $rSize = int(rand($sizeLength));
    $rColor = int(rand($colorLength));
    $rShape = int(rand($shapeLength));

    $object = $size[$rSize] . " " . $color[$rColor] . " " . $shape[$rShape];

    @objects[$i]=$object;
    print "# " . "Object " . $i . ": " . $objects[$i] . "\n";
}




for($j=0;$j<$trialLength;$j++){
    print "Start trial " . $j . "\n";
    print "} rearrange objects\n";
    for($i=0;$i<$commandLength;$i++){
	$vRand = int(rand($verbLength));
	$verbDirectObject=$objects[int(rand($objectSelectionLength))];
	$currentVerb=$verb[$vRand];
	
	if($currentVerb eq $move){
	    $dice=int(rand(2));
	    $preposition=@prep[int(rand($prepLength))];
	    $prepObject=$objects[int(rand($objectSelectionLength))];
	    $prepLocation=$location[int(rand($locationLength))];
	    if($dice==1){
		$prepArgument=$prepObject;
		$verbPreposition=$preposition;
		$goalPreposition=$preposition;
	    }
	    if($dice==0){
		$prepArgument=$prepLocation;
		$verbPreposition="to";
		$goalPreposition="in";
	    }
	    print "> Move" . " " . "the " . $verbDirectObject . " " . $verbPreposition . " " . "the " . $prepArgument . "\n";
	    print "> The goal is the " . $verbDirectObject . " " . $goalPreposition ." the ". $prepArgument . "\n";
 	    print "> Pick up the " . $verbDirectObject . "\n";
	    print "> Put the " . $verbDirectObject . " " . $verbPreposition . " " . $prepArgument . "\n";
	    print "> You are done.\n";
	    
	}
	if ($vRand==1){
	    $verbDirectObject=$objects[int(rand($objectSelectionLength))];
	    print "> Store" . " " . "the " . $verbDirectObject . "\n";
	    print "> The goal is the " . $verbDirectObject . " in the ". "pantry" . "\n";
 	    print "> Pick up the " . $verbDirectObject . "\n";
	    print "> Put the " . $verbDirectObject . " " . "in the" . " " . "pantry" . "\n";
	    print "> You are done.\n";
	}
	if ($vRand==2){
	    $verbDirectObject=$objects[int(rand($objectSelectionLength))];
	    print "> Discard" . " " . "the " . $verbDirectObject . "\n";
	    print "> The goal is the " . $verbDirectObject . " in the ". "garbage" . "\n";
 	    print "> Pick up the " . $verbDirectObject . "\n";
	    print "> Put the " . $verbDirectObject . " " . "in the" . " " . "garbage" . "\n";
	    print "> You are done.\n";
	}
	
    }
}

