#!/usr/bin/perl -w
use strict;

#The length of ARGV
my $argvLength = $#ARGV+1;

if($argvLength==0){
	print "Please enter right format !!!\n";
}elsif($argvLength==2 && $ARGV[0] eq "-n"){
	numberPartitions($ARGV[1]);
}elsif($argvLength==2 && $ARGV[0] eq "-u"){
	usedSpacePartitions($ARGV[1]);
}elsif($argvLength==2 && $ARGV[0] eq "-f"){
	freeSpacePartitons($ARGV[1]);
}elsif($argvLength==2 && $ARGV[0] eq "-s"){
	studentInfo($ARGV[1]);
}elsif($argvLength==3 && $ARGV[0] eq "-t" ){
	mountPointPartitions($ARGV[1],$ARGV[2]);
}else{
	print "Please enter right format !!!\n";
}

#option is "-n";
sub numberPartitions{
	my $file = $_[0];

	#verify the input file.
	(-r $file) or die "Filepath not found!";
	(-f $file) or die "It is not a file!";
	(-r $file) or die "The file is not readable!";
	open(INFILE,$file) or die "Error message: $!";

    my $count = 0;
    while (<INFILE>){
		chomp;
		#Skip blank line
		if($_ ne ""){
			$count++;
		}
		if($count == 0){
			print "No partitions found\n";
		}else{
			print "Number of partitions: $count\n";
		}
    }
}

#option is "-u";
sub usedSpacePartitions{
	my $file = $_[0];

	#verify the input file.
	(-r $file) or die "Filepath not found!";
	(-f $file) or die "It is not a file!";
	(-r $file) or die "The file is not readable!";
	open(INFILE,$file) or die "Error message: $!";
	
    my $usedSpace = 0;
    while (<INFILE>){
      chomp;
      if($_ ne ""){
        my @partitions = split(/ /,$_);
        $usedSpace+=$partitions[3];
      }
    }
    print "Used space: $usedSpace\n";
}

#option is "-f";
sub freeSpacePartitons{
	my $file = $_[0];

	#verify the input file.
	(-r $file) or die "Filepath not found!";
	(-f $file) or die "It is not a file!";
	(-r $file) or die "The file is not readable!";
	open(INFILE,$file) or die "Error message: $!";
	
	my $freeSpace=0;
	while (<INFILE>){
		chomp;
		if($_ ne ""){
		  my @partitions = split(/ /,$_);
		  $freeSpace+=$partitions[2]-$partitions[3];
		}
	}
    print "Free space: $freeSpace\n";
}

#option is "-t";
sub mountPointPartitions{
    my $file = $_[1];

	#verify the input file.
	(-r $file) or die "Filepath not found!";
	(-f $file) or die "It is not a file!";
	(-r $file) or die "The file is not readable!";
	open(INFILE,$file) or die "Error message: $!";
	
    my $fileSysType=$_[0];
    my $equalCount=0;
    while(<INFILE>){
		chomp;
		if($_ ne ""){
			my @partitions = split(/ /,$_);
			if($partitions[1] eq $fileSysType){
			  if($equalCount==0){
				print "Mount points with filesystem type $fileSysType:\n";
			  }
			  print $partitions[0]."\n";
			  $equalCount++;
			}
		}
    }
    if ($equalCount==0) {
		print "No mount points with this filesystem type\n";
    }
}

#option is "-s";
sub studentInfo{
	print "   Student name : "."Qian Ding"."\n";
	print "     Student ID : "."13101023"."\n";
	print "           Date : "."16/10/2018"."\n";
}