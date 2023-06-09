[top]
components : seek

% Connect Inputs for both Position and Vector layers - Top-Right, Top-Center, etc
in : inTRP inTCP inTLP inRCP inLCP inBRP inBCP inBLP 
link : inTRP inTRP@seek
link : inTCP inTCP@seek
link : inTLP inTLP@seek
link : inRCP inRCP@seek
link : inLCP inLCP@seek
link : inBRP inBRP@seek
link : inBCP inBCP@seek
link : inBLP inBLP@seek

[seek]
% Layer 0 - Current Position and Direction
% Layer 1 - Desired Velocity
type : cell
dim : (20,30,2)
delay : transport
defaultDelayTime : 100
border : wrapped
in : inTRP inTCP inTLP inRCP inLCP inBRP inBCP inBLP 
link : inTRP inTRP@seek(0,29,0)
link : inTCP inTCP@seek(0,15,0)
link : inTLP inTLP@seek(0,0,0)
link : inRCP inRCP@seek(10,29,0)
link : inLCP inLCP@seek(10,0,0)
link : inBRP inBRP@seek(19,29,0)
link : inBCP inBCP@seek(19,15,0)
link : inBLP inBLP@seek(19,0,0)

% Need visibility to variables above
neighbors : seek(-2,-2,0) seek(-2,-1,0) seek(-2,0,0) seek(-2,1,0) seek(-2,2,0)
neighbors : seek(-1,-2,0) seek(-1,-1,0) seek(-1,0,0) seek(-1,1,0) seek(-1,2,0)
neighbors : seek(0,-2,0)  seek(0,-1,0)  seek(0,0,0)  seek(0,1,0)  seek(0,2,0)
neighbors : seek(1,-2,0)  seek(1,-1,0)  seek(1,0,0)  seek(1,1,0)  seek(1,2,0)
neighbors : seek(2,-2,0)  seek(2,-1,0)  seek(2,0,0)  seek(2,1,0)  seek(2,2,0)
neighbors : seek(-2,-2,1) seek(-2,-1,1) seek(-2,0,1) seek(-2,1,1) seek(-2,2,1)
neighbors : seek(-1,-2,1) seek(-1,-1,1) seek(-1,0,1) seek(-1,1,1) seek(-1,2,1)
neighbors : seek(0,-2,1)  seek(0,-1,1)  seek(0,0,1)  seek(0,1,1)  seek(0,2,1)
neighbors : seek(1,-2,1)  seek(1,-1,1)  seek(1,0,1)  seek(1,1,1)  seek(1,2,1)
neighbors : seek(2,-2,1)  seek(2,-1,1)  seek(2,0,1)  seek(2,1,1)  seek(2,2,1)

% Desired Velocity layer stays the same
zone : constant { (0,0,1)..(19,29,1) }

initialvalue : 0
initialCellsValue : seek_in_layers.val
localtransition : move-rule

[move-rule]
% Current Position and Direction Layer (0,*,*)

%===============================================================
% Rules which do not allow a move to occur (collision avoidance)
%===============================================================

% Collision when moving up and left (lowest priority)
rule : 5 100 { 
  % We are actually moving up and left (11,51,21,24,27,41,42,43 combos): 
  ( 
    ( ((0,0,0)=1) and ((0,0,1)=1) ) or
	( ((0,0,0)=5) and ((0,0,1)=1) ) or
	( ((0,0,0)=2) and ((0,0,1)=1) ) or
	( ((0,0,0)=2) and ((0,0,1)=4) ) or
	( ((0,0,0)=2) and ((0,0,1)=7) ) or
	( ((0,0,0)=4) and ((0,0,1)=1) ) or
	( ((0,0,0)=4) and ((0,0,1)=2) ) or
	( ((0,0,0)=4) and ((0,0,1)=3) )

  )
  
  and

  % There is someone else who wants the same cell
  (
    ( ((-2,-2,0)=9) and ((-2,-2,1)=9) ) or
    ( ((-2,-2,0)=5) and ((-2,-2,1)=9) ) or
    ( ((-2,-2,0)=8) and ((-2,-2,1)=9) ) or
	( ((-2,-2,0)=8) and ((-2,-2,1)=6) ) or 
	( ((-2,-2,0)=8) and ((-2,-2,1)=3) ) or
    ( ((-2,-2,0)=6) and ((-2,-2,1)=9) ) or
	( ((-2,-2,0)=6) and ((-2,-2,1)=8) ) or
	( ((-2,-2,0)=6) and ((-2,-2,1)=7) ) or

    ( ((-2,-1,0)=8) and ((-2,-1,1)=8) ) or
    ( ((-2,-1,0)=5) and ((-2,-1,1)=8) ) or
    ( ((-2,-1,0)=9) and ((-2,-1,1)=8) ) or
	( ((-2,-1,0)=9) and ((-2,-1,1)=7) ) or 
	( ((-2,-1,0)=9) and ((-2,-1,1)=4) ) or
    ( ((-2,-1,0)=7) and ((-2,-1,1)=8) ) or
	( ((-2,-1,0)=7) and ((-2,-1,1)=9) ) or
	( ((-2,-1,0)=7) and ((-2,-1,1)=6) ) or

    ( ((-2,0,0)=7) and ((-2,0,1)=7) ) or
    ( ((-2,0,0)=5) and ((-2,0,1)=7) ) or
    ( ((-2,0,0)=8) and ((-2,0,1)=7) ) or
	( ((-2,0,0)=8) and ((-2,0,1)=4) ) or 
	( ((-2,0,0)=8) and ((-2,0,1)=1) ) or
    ( ((-2,0,0)=4) and ((-2,0,1)=7) ) or
	( ((-2,0,0)=4) and ((-2,0,1)=8) ) or
	( ((-2,0,0)=4) and ((-2,0,1)=9) ) or

	( ((-1,-2,0)=6) and ((-1,-2,1)=6) ) or
    ( ((-1,-2,0)=5) and ((-1,-2,1)=6) ) or
    ( ((-1,-2,0)=3) and ((-1,-2,1)=6) ) or
	( ((-1,-2,0)=3) and ((-1,-2,1)=9) ) or 
	( ((-1,-2,0)=3) and ((-1,-2,1)=8) ) or
    ( ((-1,-2,0)=9) and ((-1,-2,1)=6) ) or
	( ((-1,-2,0)=9) and ((-1,-2,1)=3) ) or
	( ((-1,-2,0)=9) and ((-1,-2,1)=2) ) or

	((-1,-1,0)=5) or
	( ((-1,-1,0)!=0) and ((-1,-1,1)=5) ) or

	( ((-1,0,0)=4) and ((-1,0,1)=4) ) or
    ( ((-1,0,0)=5) and ((-1,0,1)=4) ) or
    ( ((-1,0,0)=1) and ((-1,0,1)=4) ) or
	( ((-1,0,0)=1) and ((-1,0,1)=7) ) or 
	( ((-1,0,0)=1) and ((-1,0,1)=8) ) or
    ( ((-1,0,0)=7) and ((-1,0,1)=4) ) or
	( ((-1,0,0)=7) and ((-1,0,1)=1) ) or
	( ((-1,0,0)=7) and ((-1,0,1)=2) ) or

	( ((0,-2,0)=3) and ((0,-2,1)=3) ) or
    ( ((0,-2,0)=5) and ((0,-2,1)=3) ) or
    ( ((0,-2,0)=2) and ((0,-2,1)=3) ) or
	( ((0,-2,0)=2) and ((0,-2,1)=6) ) or 
	( ((0,-2,0)=2) and ((0,-2,1)=9) ) or
    ( ((0,-2,0)=6) and ((0,-2,1)=3) ) or
	( ((0,-2,0)=6) and ((0,-2,1)=2) ) or
	( ((0,-2,0)=6) and ((0,-2,1)=1) ) or

	( ((0,-1,0)=2) and ((0,-1,1)=2) ) or
    ( ((0,-1,0)=5) and ((0,-1,1)=2) ) or
    ( ((0,-1,0)=1) and ((0,-1,1)=2) ) or
	( ((0,-1,0)=1) and ((0,-1,1)=3) ) or 
	( ((0,-1,0)=1) and ((0,-1,1)=6) ) or
    ( ((0,-1,0)=3) and ((0,-1,1)=2) ) or
	( ((0,-1,0)=3) and ((0,-1,1)=1) ) or
	( ((0,-1,0)=3) and ((0,-1,1)=4) ) 
    
  ) 
}

% Collision when moving up (second lowest priority)
rule : 5 100 { 
  % We are actually moving up (22,52,12,13,16,32,31,34 combos): 
  ( 
    ( ((0,0,0)=2) and ((0,0,1)=2) ) or
	( ((0,0,0)=5) and ((0,0,1)=2) ) or
	( ((0,0,0)=1) and ((0,0,1)=2) ) or
	( ((0,0,0)=1) and ((0,0,1)=3) ) or
	( ((0,0,0)=1) and ((0,0,1)=6) ) or
	( ((0,0,0)=3) and ((0,0,1)=2) ) or
	( ((0,0,0)=3) and ((0,0,1)=1) ) or
	( ((0,0,0)=3) and ((0,0,1)=4) )

  )
  
  and

  % There is someone else who wants the same cell
  (
    ( ((-2,-1,0)=9) and ((-2,-1,1)=9) ) or
    ( ((-2,-1,0)=5) and ((-2,-1,1)=9) ) or
    ( ((-2,-1,0)=8) and ((-2,-1,1)=9) ) or
	( ((-2,-1,0)=8) and ((-2,-1,1)=6) ) or 
	( ((-2,-1,0)=8) and ((-2,-1,1)=3) ) or
    ( ((-2,-1,0)=6) and ((-2,-1,1)=9) ) or
	( ((-2,-1,0)=6) and ((-2,-1,1)=8) ) or
	( ((-2,-1,0)=6) and ((-2,-1,1)=7) ) or

    ( ((-2,0,0)=8) and ((-2,0,1)=8) ) or
    ( ((-2,0,0)=5) and ((-2,0,1)=8) ) or
    ( ((-2,0,0)=9) and ((-2,0,1)=8) ) or
	( ((-2,0,0)=9) and ((-2,0,1)=7) ) or 
	( ((-2,0,0)=9) and ((-2,0,1)=4) ) or
    ( ((-2,0,0)=7) and ((-2,0,1)=8) ) or
	( ((-2,0,0)=7) and ((-2,0,1)=9) ) or
	( ((-2,0,0)=7) and ((-2,0,1)=6) ) or

    ( ((-2,1,0)=7) and ((-2,1,1)=7) ) or
    ( ((-2,1,0)=5) and ((-2,1,1)=7) ) or
    ( ((-2,1,0)=8) and ((-2,1,1)=7) ) or
	( ((-2,1,0)=8) and ((-2,1,1)=4) ) or 
	( ((-2,1,0)=8) and ((-2,1,1)=1) ) or
    ( ((-2,1,0)=4) and ((-2,1,1)=7) ) or
	( ((-2,1,0)=4) and ((-2,1,1)=8) ) or
	( ((-2,1,0)=4) and ((-2,1,1)=9) ) or

	( ((-1,-1,0)=6) and ((-1,-1,1)=6) ) or
    ( ((-1,-1,0)=5) and ((-1,-1,1)=6) ) or
    ( ((-1,-1,0)=3) and ((-1,-1,1)=6) ) or
	( ((-1,-1,0)=3) and ((-1,-1,1)=9) ) or 
	( ((-1,-1,0)=3) and ((-1,-1,1)=8) ) or
    ( ((-1,-1,0)=9) and ((-1,-1,1)=6) ) or
	( ((-1,-1,0)=9) and ((-1,-1,1)=3) ) or
	( ((-1,-1,0)=9) and ((-1,-1,1)=2) ) or

	((-1,0,0)=5) or
	( ((-1,0,0)!=0) and ((-1,0,1)=5) ) or

	( ((-1,1,0)=4) and ((-1,1,1)=4) ) or
    ( ((-1,1,0)=5) and ((-1,1,1)=4) ) or
    ( ((-1,1,0)=1) and ((-1,1,1)=4) ) or
	( ((-1,1,0)=1) and ((-1,1,1)=7) ) or 
	( ((-1,1,0)=1) and ((-1,1,1)=8) ) or
    ( ((-1,1,0)=7) and ((-1,1,1)=4) ) or
	( ((-1,1,0)=7) and ((-1,1,1)=1) ) or
	( ((-1,1,0)=7) and ((-1,1,1)=2) ) or

	( ((0,-1,0)=3) and ((0,-1,1)=3) ) or
    ( ((0,-1,0)=5) and ((0,-1,1)=3) ) or
    ( ((0,-1,0)=2) and ((0,-1,1)=3) ) or
	( ((0,-1,0)=2) and ((0,-1,1)=6) ) or 
	( ((0,-1,0)=2) and ((0,-1,1)=9) ) or
    ( ((0,-1,0)=6) and ((0,-1,1)=3) ) or
	( ((0,-1,0)=6) and ((0,-1,1)=2) ) or
	( ((0,-1,0)=6) and ((0,-1,1)=1) )
  )
}

% Collision when moving up and right (third lowest priority)
rule : 5 100 { 
  % We are actually moving up and right (33,53,23,26,29,63,62,61 combos): 
  ( 
    ( ((0,0,0)=3) and ((0,0,1)=3) ) or
	( ((0,0,0)=5) and ((0,0,1)=3) ) or
	( ((0,0,0)=3) and ((0,0,1)=3) ) or
	( ((0,0,0)=3) and ((0,0,1)=6) ) or
	( ((0,0,0)=3) and ((0,0,1)=9) ) or
	( ((0,0,0)=6) and ((0,0,1)=3) ) or
	( ((0,0,0)=6) and ((0,0,1)=2) ) or
	( ((0,0,0)=6) and ((0,0,1)=1) )

  )
  
  and

  % There is someone else who wants the same cell
  (
    ( ((-2,0,0)=9) and ((-2,0,1)=9) ) or
    ( ((-2,0,0)=5) and ((-2,0,1)=9) ) or
    ( ((-2,0,0)=8) and ((-2,0,1)=9) ) or
	( ((-2,0,0)=8) and ((-2,0,1)=6) ) or 
	( ((-2,0,0)=8) and ((-2,0,1)=3) ) or
    ( ((-2,0,0)=6) and ((-2,0,1)=9) ) or
	( ((-2,0,0)=6) and ((-2,0,1)=8) ) or
	( ((-2,0,0)=6) and ((-2,0,1)=7) ) or

    ( ((-2,1,0)=8) and ((-2,1,1)=8) ) or
    ( ((-2,1,0)=5) and ((-2,1,1)=8) ) or
    ( ((-2,1,0)=9) and ((-2,1,1)=8) ) or
	( ((-2,1,0)=9) and ((-2,1,1)=7) ) or 
	( ((-2,1,0)=9) and ((-2,1,1)=4) ) or
    ( ((-2,1,0)=7) and ((-2,1,1)=8) ) or
	( ((-2,1,0)=7) and ((-2,1,1)=9) ) or
	( ((-2,1,0)=7) and ((-2,1,1)=6) ) or

    ( ((-2,2,0)=7) and ((-2,2,1)=7) ) or
    ( ((-2,2,0)=5) and ((-2,2,1)=7) ) or
    ( ((-2,2,0)=8) and ((-2,2,1)=7) ) or
	( ((-2,2,0)=8) and ((-2,2,1)=4) ) or 
	( ((-2,2,0)=8) and ((-2,2,1)=1) ) or
    ( ((-2,2,0)=4) and ((-2,2,1)=7) ) or
	( ((-2,2,0)=4) and ((-2,2,1)=8) ) or
	( ((-2,2,0)=4) and ((-2,2,1)=9) ) or

	( ((-1,0,0)=6) and ((-1,0,1)=6) ) or
    ( ((-1,0,0)=5) and ((-1,0,1)=6) ) or
    ( ((-1,0,0)=3) and ((-1,0,1)=6) ) or
	( ((-1,0,0)=3) and ((-1,0,1)=9) ) or 
	( ((-1,0,0)=3) and ((-1,0,1)=8) ) or
    ( ((-1,0,0)=9) and ((-1,0,1)=6) ) or
	( ((-1,0,0)=9) and ((-1,0,1)=3) ) or
	( ((-1,0,0)=9) and ((-1,0,1)=2) ) or

	((-1,1,0)=5) or
	( ((-1,1,0)!=0) and ((-1,1,1)=5) ) or

	( ((-1,2,0)=4) and ((-1,2,1)=4) ) or
    ( ((-1,2,0)=5) and ((-1,2,1)=4) ) or
    ( ((-1,2,0)=1) and ((-1,2,1)=4) ) or
	( ((-1,2,0)=1) and ((-1,2,1)=7) ) or 
	( ((-1,2,0)=1) and ((-1,2,1)=8) ) or
    ( ((-1,2,0)=7) and ((-1,2,1)=4) ) or
	( ((-1,2,0)=7) and ((-1,2,1)=1) ) or
	( ((-1,2,0)=7) and ((-1,2,1)=2) )
  )
}

% Collision when moving left (fourth lowest priority)
rule : 5 100 { 
  % We are actually moving left (44,54,14,17,18,74,71,72 combos): 
  ( 
    ( ((0,0,0)=4) and ((0,0,1)=4) ) or
	( ((0,0,0)=5) and ((0,0,1)=4) ) or
	( ((0,0,0)=1) and ((0,0,1)=4) ) or
	( ((0,0,0)=1) and ((0,0,1)=7) ) or
	( ((0,0,0)=1) and ((0,0,1)=8) ) or
	( ((0,0,0)=7) and ((0,0,1)=4) ) or
	( ((0,0,0)=7) and ((0,0,1)=1) ) or
	( ((0,0,0)=7) and ((0,0,1)=2) )

  ) and

  % There is someone else who wants the same cell
  (
    ( ((-1,-2,0)=9) and ((-1,-2,1)=9) ) or
    ( ((-1,-2,0)=5) and ((-1,-2,1)=9) ) or
    ( ((-1,-2,0)=8) and ((-1,-2,1)=9) ) or
	( ((-1,-2,0)=8) and ((-1,-2,1)=6) ) or 
	( ((-1,-2,0)=8) and ((-1,-2,1)=3) ) or
    ( ((-1,-2,0)=6) and ((-1,-2,1)=9) ) or
	( ((-1,-2,0)=6) and ((-1,-2,1)=8) ) or
	( ((-1,-2,0)=6) and ((-1,-2,1)=7) ) or

    ( ((-1,-1,0)=8) and ((-1,-1,1)=8) ) or
    ( ((-1,-1,0)=5) and ((-1,-1,1)=8) ) or
    ( ((-1,-1,0)=9) and ((-1,-1,1)=8) ) or
	( ((-1,-1,0)=9) and ((-1,-1,1)=7) ) or 
	( ((-1,-1,0)=9) and ((-1,-1,1)=4) ) or
    ( ((-1,-1,0)=7) and ((-1,-1,1)=8) ) or
	( ((-1,-1,0)=7) and ((-1,-1,1)=9) ) or
	( ((-1,-1,0)=7) and ((-1,-1,1)=6) ) or

    ( ((-1,0,0)=7) and ((-1,0,1)=7) ) or
    ( ((-1,0,0)=5) and ((-1,0,1)=7) ) or
    ( ((-1,0,0)=8) and ((-1,0,1)=7) ) or
	( ((-1,0,0)=8) and ((-1,0,1)=4) ) or 
	( ((-1,0,0)=8) and ((-1,0,1)=1) ) or
    ( ((-1,0,0)=4) and ((-1,0,1)=7) ) or
	( ((-1,0,0)=4) and ((-1,0,1)=8) ) or
	( ((-1,0,0)=4) and ((-1,0,1)=9) ) or

	( ((0,-2,0)=6) and ((0,-2,1)=6) ) or
    ( ((0,-2,0)=5) and ((0,-2,1)=6) ) or
    ( ((0,-2,0)=3) and ((0,-2,1)=6) ) or
	( ((0,-2,0)=3) and ((0,-2,1)=9) ) or 
	( ((0,-2,0)=3) and ((0,-2,1)=8) ) or
    ( ((0,-2,0)=9) and ((0,-2,1)=6) ) or
	( ((0,-2,0)=9) and ((0,-2,1)=3) ) or
	( ((0,-2,0)=9) and ((0,-2,1)=2) ) or

	((0,-1,0)=5) or
	( ((0,-1,0)!=0) and ((0,-1,1)=5) )

  )
}

% There is no collision when we stay still!

% Collision when moving right (fifth lowest priority)
rule : 5 100 { 
  % We are actually moving right (66,56,36,31,38,96,93,92 combos): 
  ( 
    ( ((0,0,0)=6) and ((0,0,1)=6) ) or
	( ((0,0,0)=5) and ((0,0,1)=6) ) or
	( ((0,0,0)=3) and ((0,0,1)=6) ) or
	( ((0,0,0)=3) and ((0,0,1)=1) ) or
	( ((0,0,0)=3) and ((0,0,1)=8) ) or
	( ((0,0,0)=9) and ((0,0,1)=6) ) or
	( ((0,0,0)=9) and ((0,0,1)=3) ) or
	( ((0,0,0)=9) and ((0,0,1)=2) )

  ) and

  % There is someone else who wants the same cell
  (
    ( ((-1,0,0)=9) and ((-1,0,1)=9) ) or
    ( ((-1,0,0)=5) and ((-1,0,1)=9) ) or
    ( ((-1,0,0)=8) and ((-1,0,1)=9) ) or
	( ((-1,0,0)=8) and ((-1,0,1)=6) ) or 
	( ((-1,0,0)=8) and ((-1,0,1)=3) ) or
    ( ((-1,0,0)=6) and ((-1,0,1)=9) ) or
	( ((-1,0,0)=6) and ((-1,0,1)=8) ) or
	( ((-1,0,0)=6) and ((-1,0,1)=7) ) or

    ( ((-1,1,0)=8) and ((-1,1,1)=8) ) or
    ( ((-1,1,0)=5) and ((-1,1,1)=8) ) or
    ( ((-1,1,0)=9) and ((-1,1,1)=8) ) or
	( ((-1,1,0)=9) and ((-1,1,1)=7) ) or 
	( ((-1,1,0)=9) and ((-1,1,1)=4) ) or
    ( ((-1,1,0)=7) and ((-1,1,1)=8) ) or
	( ((-1,1,0)=7) and ((-1,1,1)=9) ) or
	( ((-1,1,0)=7) and ((-1,1,1)=6) ) or

    ( ((-1,2,0)=7) and ((-1,2,1)=7) ) or
    ( ((-1,2,0)=5) and ((-1,2,1)=7) ) or
    ( ((-1,2,0)=8) and ((-1,2,1)=7) ) or
	( ((-1,2,0)=8) and ((-1,2,1)=4) ) or 
	( ((-1,2,0)=8) and ((-1,2,1)=1) ) or
    ( ((-1,2,0)=4) and ((-1,2,1)=7) ) or
	( ((-1,2,0)=4) and ((-1,2,1)=8) ) or
	( ((-1,2,0)=4) and ((-1,2,1)=9) ) or

	((0,1,0)=5) or
	( ((0,1,0)!=0) and ((0,1,1)=5) )

  )
}
  
% Collision when moving down and left (sixth lowest priority)
rule : 5 100 { 
  % We are actually moving down and left (77,57,87,84,81,47,48,49 combos): 
  ( 
    ( ((0,0,0)=7) and ((0,0,1)=7) ) or
	( ((0,0,0)=5) and ((0,0,1)=7) ) or
	( ((0,0,0)=8) and ((0,0,1)=7) ) or
	( ((0,0,0)=8) and ((0,0,1)=4) ) or
	( ((0,0,0)=8) and ((0,0,1)=1) ) or
	( ((0,0,0)=4) and ((0,0,1)=7) ) or
	( ((0,0,0)=4) and ((0,0,1)=8) ) or
	( ((0,0,0)=4) and ((0,0,1)=9) )

  ) and

  % There is someone else who wants the same cell
  (
    ( ((0,-2,0)=9) and ((0,-2,1)=9) ) or
    ( ((0,-2,0)=5) and ((0,-2,1)=9) ) or
    ( ((0,-2,0)=8) and ((0,-2,1)=9) ) or
	( ((0,-2,0)=8) and ((0,-2,1)=6) ) or 
	( ((0,-2,0)=8) and ((0,-2,1)=3) ) or
    ( ((0,-2,0)=6) and ((0,-2,1)=9) ) or
	( ((0,-2,0)=6) and ((0,-2,1)=8) ) or
	( ((0,-2,0)=6) and ((0,-2,1)=7) ) or

    ( ((0,-1,0)=8) and ((0,-1,1)=8) ) or
    ( ((0,-1,0)=5) and ((0,-1,1)=8) ) or
    ( ((0,-1,0)=9) and ((0,-1,1)=8) ) or
	( ((0,-1,0)=9) and ((0,-1,1)=7) ) or 
	( ((0,-1,0)=9) and ((0,-1,1)=4) ) or
    ( ((0,-1,0)=7) and ((0,-1,1)=8) ) or
	( ((0,-1,0)=7) and ((0,-1,1)=9) ) or
	( ((0,-1,0)=7) and ((0,-1,1)=6) ) or

	((1,-1,0)=5) or
	( ((1,-1,0)!=0) and ((1,-1,1)=5) )

  )
}

% Collision when moving down (seventh lowest priority)
rule : 5 100 { 
  % We are actually moving down (88,58,98,97,94,78,79,76 combos): 
  ( 
    ( ((0,0,0)=8) and ((0,0,1)=8) ) or
	( ((0,0,0)=5) and ((0,0,1)=8) ) or
	( ((0,0,0)=9) and ((0,0,1)=8) ) or
	( ((0,0,0)=9) and ((0,0,1)=7) ) or
	( ((0,0,0)=9) and ((0,0,1)=4) ) or
	( ((0,0,0)=7) and ((0,0,1)=8) ) or
	( ((0,0,0)=7) and ((0,0,1)=9) ) or
	( ((0,0,0)=7) and ((0,0,1)=6) )

  ) and

  % There is someone else who wants the same cell
  (
    ( ((0,-1,0)=9) and ((0,-1,1)=9) ) or
    ( ((0,-1,0)=5) and ((0,-1,1)=9) ) or
    ( ((0,-1,0)=8) and ((0,-1,1)=9) ) or
	( ((0,-1,0)=8) and ((0,-1,1)=6) ) or 
	( ((0,-1,0)=8) and ((0,-1,1)=3) ) or
    ( ((0,-1,0)=6) and ((0,-1,1)=9) ) or
	( ((0,-1,0)=6) and ((0,-1,1)=8) ) or
	( ((0,-1,0)=6) and ((0,-1,1)=7) ) or

	((1,0,0)=5) or
	( ((1,0,0)!=0) and ((1,0,1)=5) )

  )
}

% Collision when moving down and right (eighth lowest priority)
rule : 5 100 { 
  % We are actually moving down and right (99,59,89,86,83,69,68,67 combos): 
  ( 
    ( ((0,0,0)=9) and ((0,0,1)=9) ) or
	( ((0,0,0)=5) and ((0,0,1)=9) ) or
	( ((0,0,0)=8) and ((0,0,1)=9) ) or
	( ((0,0,0)=8) and ((0,0,1)=6) ) or
	( ((0,0,0)=8) and ((0,0,1)=3) ) or
	( ((0,0,0)=6) and ((0,0,1)=9) ) or
	( ((0,0,0)=6) and ((0,0,1)=8) ) or
	( ((0,0,0)=6) and ((0,0,1)=7) )

  ) and

  % There is someone else who wants the same cell
  (
	((1,1,0)=5) or
	( ((1,1,0)!=0) and ((1,1,1)=5) )

  )
}

%===============================================================
% Rules which do allow a move to occur
%===============================================================

% Stay - Has highest priority
rule : 5 100 {
  % Collisions accounted for previously

  % We are staying still
  (
    ( ((0,0,0) = 1) and  ((0,0,1) = 9) ) or
    ( ((0,0,0) = 2) and  ((0,0,1) = 8) ) or
    ( ((0,0,0) = 3) and  ((0,0,1) = 7) ) or
    ( ((0,0,0) = 4) and  ((0,0,1) = 6) ) or
    ( ((0,0,0) != 0) and ((0,0,1) = 5) ) or
    ( ((0,0,0) = 6) and  ((0,0,1) = 4) ) or
    ( ((0,0,0) = 7) and  ((0,0,1) = 3) ) or
    ( ((0,0,0) = 8) and  ((0,0,1) = 2) ) or
    ( ((0,0,0) = 9) and  ((0,0,1) = 1) )
  )
}

% Up and Left
rule : 1 100 { 
  % Collisions accounted for previously

  % We are actually moving up and left (11,51,21,24,27,41,42,43 combos): 
  ( 
    ( ((1,1,0)=1) and ((1,1,1)=1) ) or
	( ((1,1,0)=5) and ((1,1,1)=1) ) or
	( ((1,1,0)=2) and ((1,1,1)=1) ) or
	( ((1,1,0)=2) and ((1,1,1)=4) ) or
	( ((1,1,0)=2) and ((1,1,1)=7) ) or
	( ((1,1,0)=4) and ((1,1,1)=1) ) or
	( ((1,1,0)=4) and ((1,1,1)=2) ) or
	( ((1,1,0)=4) and ((1,1,1)=3) )

  )
}

% Up
rule : 2 100 { 
  % Collisions accounted for previously

  % We are actually moving up (22,52,12,13,16,32,31,34 combos): 
  ( 
    ( ((1,0,0)=2) and ((1,0,1)=2) ) or
	( ((1,0,0)=5) and ((1,0,1)=2) ) or
	( ((1,0,0)=1) and ((1,0,1)=2) ) or
	( ((1,0,0)=1) and ((1,0,1)=3) ) or
	( ((1,0,0)=1) and ((1,0,1)=6) ) or
	( ((1,0,0)=3) and ((1,0,1)=2) ) or
	( ((1,0,0)=3) and ((1,0,1)=1) ) or
	( ((1,0,0)=3) and ((1,0,1)=4) )

  )
}

% Up and Right
rule : 3 100 {
  % Collisions accounted for previously

  % We are actually moving up and right (33,53,23,26,29,63,62,61 combos): 
  ( 
    ( ((1,-1,0) = 3) and ((1,-1,1) = 3) ) or
	( ((1,-1,0) = 5) and ((1,-1,1) = 3) ) or
	( ((1,-1,0) = 2) and ((1,-1,1) = 3) ) or
	( ((1,-1,0) = 2) and ((1,-1,1) = 6) ) or
	( ((1,-1,0) = 2) and ((1,-1,1) = 9) ) or
	( ((1,-1,0) = 6) and ((1,-1,1) = 3) ) or
	( ((1,-1,0) = 6) and ((1,-1,1) = 2) ) or
	( ((1,-1,0) = 6) and ((1,-1,1) = 1) )
  )
}

% Left
rule : 4 100 { 
  % Collisions accounted for previously

  % We are actually moving left (44,54,14,17,18,74,71,72 combos): 
  (
    ( ((0,1,0) = 4) and ((0,1,1) = 4) ) or
	( ((0,1,0) = 5) and ((0,1,1) = 4) ) or
	( ((0,1,0) = 1) and ((0,1,1) = 4) ) or
	( ((0,1,0) = 1) and ((0,1,1) = 7) ) or
	( ((0,1,0) = 1) and ((0,1,1) = 8) ) or
	( ((0,1,0) = 7) and ((0,1,1) = 4) ) or
	( ((0,1,0) = 7) and ((0,1,1) = 1) ) or
	( ((0,1,0) = 7) and ((0,1,1) = 2) ) 
  )
}

% Right
rule : 6 100 {
  % Collisions accounted for previously

  % We are actually moving right (66,56,36,39,38,96,93,92 combos): 
  (
    ( ((0,-1,0) = 6) and ((0,-1,1) = 6) ) or 
	( ((0,-1,0) = 5) and ((0,-1,1) = 6) ) or
	( ((0,-1,0) = 3) and ((0,-1,1) = 6) ) or
	( ((0,-1,0) = 3) and ((0,-1,1) = 9) ) or
	( ((0,-1,0) = 3) and ((0,-1,1) = 8) ) or
	( ((0,-1,0) = 9) and ((0,-1,1) = 6) ) or
	( ((0,-1,0) = 9) and ((0,-1,1) = 3) ) or
	( ((0,-1,0) = 9) and ((0,-1,1) = 2) )
  )
}

% Down and Left
rule : 7 100 {
  % Collisions accounted for previously

  % We are actually moving down and left (77,57,87,84,81,47,48,49 combos): 
  (
    ( ((-1,1,0) = 7) and ((-1,1,1) = 7) ) or
	( ((-1,1,0) = 5) and ((-1,1,1) = 7) ) or
	( ((-1,1,0) = 8) and ((-1,1,1) = 7) ) or
	( ((-1,1,0) = 8) and ((-1,1,1) = 4) ) or
	( ((-1,1,0) = 8) and ((-1,1,1) = 1) ) or
	( ((-1,1,0) = 4) and ((-1,1,1) = 7) ) or
	( ((-1,1,0) = 4) and ((-1,1,1) = 8) ) or
	( ((-1,1,0) = 4) and ((-1,1,1) = 9) )
  )
}

% Down
rule : 8 100 {
  % Collisions accounted for previously

  % We are actually moving down (87,58,98,97,94,78,79,76 combos): 
  (
    ( ((-1,0,0) = 8) and ((-1,0,1) = 8) ) or
	( ((-1,0,0) = 5) and ((-1,0,1) = 8) ) or
	( ((-1,0,0) = 9) and ((-1,0,1) = 8) ) or
	( ((-1,0,0) = 9) and ((-1,0,1) = 7) ) or
	( ((-1,0,0) = 9) and ((-1,0,1) = 4) ) or
	( ((-1,0,0) = 7) and ((-1,0,1) = 8) ) or
	( ((-1,0,0) = 7) and ((-1,0,1) = 9) ) or
	( ((-1,0,0) = 7) and ((-1,0,1) = 6) ) 
  )
}

% Down and Right
rule : 9 100 { 
  % Collisions accounted for previously

  % We are actually moving down and right (99,59,89,86,83,69,68,67 combos): 
  (
    ( ((-1,-1,0) = 9) and ((-1,-1,1) = 9) ) or
	( ((-1,-1,0) = 5) and ((-1,-1,1) = 9) ) or
	( ((-1,-1,0) = 8) and ((-1,-1,1) = 9) ) or
	( ((-1,-1,0) = 8) and ((-1,-1,1) = 6) ) or
	( ((-1,-1,0) = 8) and ((-1,-1,1) = 3) ) or
	( ((-1,-1,0) = 6) and ((-1,-1,1) = 9) ) or
	( ((-1,-1,0) = 6) and ((-1,-1,1) = 8) ) or
	( ((-1,-1,0) = 6) and ((-1,-1,1) = 7) ) 
  )
}

% Default behaviour
rule : 0 100 { t }

[constant]
% Target Vector Layer (1,*,*) - Target is at (15,10) (across, down)
rule : { (0,0,0) } 100 { t }
