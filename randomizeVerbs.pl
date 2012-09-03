#!/usr/bin/perl

@verb=("move","store","discard");

@size=("small","large");
$sizeLength=@size;

@color=("red","blue","green");
$colorLength=@color;

@shape=("triangle","arch","rectangle");
$shapeLength=@shape;

@location=("pantry","stove","garbage","table");
$locationLength=@location;

@prep=("to the left of","to the right of","in");
$prepLength=@prep;

@situation=("empty","correct");
$situationLength=@situation;

@instruction=("direct","indirect");
$instructionLength=@instruction;


$objectSelectionLength=$ARGV[0];
$trialLength=$ARGV[1];

my @alreadySelected;


print "#!BechtelFormat \n";
print "@ classifier clear \n";

print "# Objects for the run are\n";
for($i=0;$i<$objectSelectionLength;$i++){

    
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
    $alreadySelected[$i]=$number;
   
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

### train for all objects
print "# Training the agent for all objects \n";
for ($i=0;$i<$objectSelectionLength;$i++){
    print "} Put the " . $objects[$i] . " on the board\n";
    print "> Point to the ". $objects[$i] . "\n";
    print $teachObjects[$i];
    print "} Reset arm\n";
}

### train all the prepositions
print "# Training the agent for all prepositions \n";
for ($i=0;$i<$prepLength;$i++){
	print "} Place the " . $objects[0] . " " . $prep[$i]. " the table\n";
	print "> The " . $objects[0] . " is " . $prep[$i]. " the table\n> Finished \n";
}

### create trials for verbs
for($j=0;$j<$trialLength;$j++){
    print "# Start trial " . $j . "\n";
    print "} rearrange objects \n";
    for($i=0;$i<3;$i++){
	print "# Starting command " . $count++ . "\n";
	### create random argument
	$objectIndex = int(rand($objectSelectionLength));
	$verbDirectObject=$objects[$objectIndex];
	if($verb[$i] eq "move"){
	    for($k=0;$k<$prepLength;$k++){
	      START:
		$locationIndex = int(rand($objectSelectionLength));
		if($locationIndex==$objectIndex){
		    goto START;
		}
		
		$goalPreposition = $prep[$k];
		$verbLocation = $location[int(rand($locationLength))];
		if($goalPreposition eq "in"){
		    $verbArgument = $verbLocation;
		    $verbPreposition = "to";
		}
		else {
		    if(int(rand(2))==0){
			$verbArgument = $verbLocation;
		    }
		    else{
			$verbArgument = $objects[$locationIndex];
		    }
		    $verbPreposition = $goalPreposition;
		}

		$boolSituation = int(rand(2));
		print "} Place" . " the " . $verbDirectObject . " anywhere other than ". $goalPreposition. " the ". $verbArgument ."\n"; 
		if ($situation[$boolSituation] eq "correct"){
		    print "> Pick up the ". $verbDirectObject . "\n";
		}
		print "> ". $verb[$i] . " " . "the " . $verbDirectObject . " ". $verbPreposition. " the ". $verbArgument. "\n";
		print "> The goal is the " . $verbDirectObject . " ".$goalPreposition." the ". $verbArgument . "\n";
		if ($situation[$boolSituation] ne "correct"){
		    print "> Pick up the ". $verbDirectObject . "\n";
		}
		if ($instruction[int(rand(2))] eq "indirect"){
		    print "> Put the " . $verbDirectObject . " " ."in the" . " " . "table" . "\n";
		    print "> Pick up the ". $verbDirectObject . "\n";
		}
		print "> Put the " . $verbDirectObject . " " . $goalPreposition ." the" . " " . $verbArgument . "\n";
		print "> You are done.\n";
		
	    }
	    
	}
	if ($verb[$i] ne "move"){

	    if($verb[$i] eq "discard") {$prepLocation = "garbage";}
	    if($verb[$i] eq "store") {$prepLocation = "pantry";}

	    $boolSituation = int(rand(2));
            print "} Place" . " the " . $verbDirectObject . " anywhere other than in the ". $prepLocation ."\n"; 
	    if ($situation[$boolSituation] eq "correct"){
		print "> Pick up the ". $verbDirectObject . "\n";
	    }
	    print "> ". $verb[$i] . " " . "the " . $verbDirectObject . "\n";
	    print "> The goal is the " . $verbDirectObject . " in the ". $prepLocation . "\n";
	    if ($situation[$boolSituation] ne "correct"){
		print "> Pick up the ". $verbDirectObject . "\n";
	    }
	    if ($instruction[int(rand(2))] eq "indirect"){
		print "> Put the " . $verbDirectObject . " " . "in the" . " " . "table" . "\n";
		print "> Pick up the ". $verbDirectObject . "\n";
	    }
	    print "> Put the " . $verbDirectObject . " " . "in the" . " " . $prepLocation . "\n";
	    print "> You are done.\n";
	}
    }
}

