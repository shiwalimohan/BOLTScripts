#!/usr/bin/perl


#### ./randomizeCombined.perl <number of objects> <number of verb commands in one trial> <number of trials>


@verb=("move","store","discard","move","move");
$verbLength=@verb;

@size=("small","large");
$sizeLength=@size;

@color=("red","yellow","green");
$colorLength=@color;

@shape=("triangle","arch","rectangle");
$shapeLength=@shape;

@location=("pantry","dishwasher","garbage","table");
$locationLength=@location;

@prep=("to the left of","to the right of","near","in");
$prepLength=@prep;


$objectSelectionLength=$ARGV[0];
$commandLength=$ARGV[1];
$trialLength=$ARGV[2];

$move = "move";
$store = "store";
$discard = "discard";

$demoObject1 = "small red circle";
$demoObject2 = "small blue circle";

my @alreadySelected;


print "#!BechtelFormat \n";
print "@ classifier clear \n";

print "# Objects for the run are\n";
for($i=0;$i<$objectSelectionLength;$i++){

    my $found;
    
  START:
    $rSize = int(rand($sizeLength));
    $rColor = int(rand($colorLength));
    $rShape = int(rand($shapeLength));
    $number=int($rSize.$rColor.$rShape);
    for($r=0;$r<@alreadySelected;$r++){
	if($alreadySelected[$r] == $number){
	    goto START;
	}
    }

    @alreadySelected[$i]=$number;

    $selectedSize=$size[$rSize];
    $selectedColor=$color[$rColor];
    $selectedShape=$shape[$rShape];

    @selectedObject=($selectedSize,$selectedColor,$selectedShape);
    @sortedObject=sort @selectedObject;

    $object = $selectedSize . " " . $selectedColor . " " . $selectedShape;

    $k = 0;  
    for($j=0;$j<3;$j++){
	if($sortedObject[$j] eq $selectedSize){
	    $aString[$k++] = "> ". $selectedSize . " is a size.";
	}

	if($sortedObject[$j] eq $selectedShape){
	    $aString[$k++]="> ". $selectedShape . " is a shape.";
	}

	if($sortedObject[$j] eq $selectedColor){
	    $aString[$k++]="> " . $selectedColor . " is a color.";
	}
    }

    $aString[$k++]= "} " . "Select the " . $object;
    $aString[$k++] = "> " . "This is " . $selectedSize;
    $aString[$k++] = "> " . "This is a " . $selectedShape;
    $aString[$k++] = "> " . "This is " . $selectedColor;

    $teachInteraction= join "\n",@aString;

    @objects[$i]=$object;
    @teachObjects[$i]=$teachInteraction . "\n> Finished. \n";


    print "# " . "Object " . $i . ": " . $objects[$i] . "\n";
}




for($j=0;$j<$trialLength;$j++){
    print "Start trial " . $j . "\n";
    print "} rearrange objects \n";
    for($i=0;$i<$commandLength;$i++){
	print "# Starting command " . $i . "\n";
	$vRand = int(rand($verbLength));
	$objectIndex = int(rand($objectSelectionLength));
	$verbDirectObject=$objects[$objectIndex];
	$objectInteraction=$teachObjects[$objectIndex];
	$currentVerb=$verb[$vRand];
	
	if($currentVerb eq $move){
	    $preposition=@prep[int(rand($prepLength))];
	    $prepLocation=$location[int(rand($locationLength))];
	    $prepArgument=$prepLocation;
	    if($preposition eq "in"){
	        $verbPreposition="to";
		$goalPreposition="in";
	    }
	    else{
		$verbPreposition=$preposition;
		$goalPreposition=$preposition;
	    }
	  
	    print "} Place" . " the " . $verbDirectObject . " anywhere but " . $verbPreposition . " the " . $prepArgument . "\n"; 
	    print "> Move" . " " . "the " . $verbDirectObject . " " . $verbPreposition . " " . "the " . $prepArgument . "\n";
	    print $objectInteraction;
	    if ($verbPreposition ne "to"){
		print "} Place the " . $demoObject1 . " " . $verbPreposition . " the " . $demoObject2 . "\n";
		print "> The " . $demoObject1 . " is " . $verbPreposition . " the " . $demoObject2 . "\n> Finished \n";
		print "} Remove demo objects\n";
	    }
	    print "> The goal is the " . $verbDirectObject . " " . $goalPreposition ." the ". $prepArgument . "\n";
            if ($verbPreposition eq "to"){
		print "} Place the " . $demoObject1 . " in the table\n";
		print "> The " . $demoObject1 . " is in the table\n> Finished \n";
		print "} Remove demo objects\n";
	    }
 	    print "> Pick up the " . $verbDirectObject . "\n";
	    print "> Put the " . $verbDirectObject . " " . $goalPreposition . " " . $prepArgument . "\n";
	    print "> You are done.\n";
	    
	}

	if ($currentVerb eq $store){
	    print "> Store" . " " . "the " . $verbDirectObject . "\n";
	    print $objectInteraction;
	    print "> The goal is the " . $verbDirectObject . " in the ". "pantry" . "\n";
	    print "} Place the " . $demoObject1 . " in the table\n";
	    print "> The " . $demoObject1 . " is in the table\n> Finished \n";
	    print "} Remove demo objects\n";
 	    print "> Pick up the " . $verbDirectObject . "\n";
	    print "> Put the " . $verbDirectObject . " " . "in the" . " " . "pantry" . "\n";
	    print "> You are done.\n";
	}
	if ($currentVerb eq $discard){
	    print "> Discard" . " " . "the " . $verbDirectObject . "\n";
	    print $objectInteraction;
	    print "> The goal is the " . $verbDirectObject . " in the ". "garbage" . "\n";
	    print "} Place the " . $demoObject1 . " in the table\n";
	    print "> The " . $demoObject1 . " is in the table\n> Finished \n";
	    print "} Remove demo objects\n";
 	    print "> Pick up the " . $verbDirectObject . "\n";
	    print "> Put the " . $verbDirectObject . " " . "in the" . " " . "garbage" . "\n";
	    print "> You are done.\n";
	}
	
    }
}

