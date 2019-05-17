#!/usr/bin/perl -w

$opt = $ARGV[0];

if($opt eq "-a"){
        #Available locales
        scanFile("locale");
        printResult("locale");
        close(INFILE);
}elsif($opt eq "-m"){
        #Available charmaps
        scanFile("charmap");
        printResult("charmap");
        close(INFILE);
}elsif($opt eq "-s"){
        #Total size in bytes of all locales: <total size in bytes of all locales>
        scanFile("locale");
        if(scalar(@sizeAry) > 0){
                $sizeSum = 0;
                foreach $size(@sizeAry){
                        $sizeSum += $size;
                }
                print "Total size in bytes of all locales: " . $sizeSum . "\n";
        }else{
                print "Total size in bytes of all locales: 0\n";
        }
        close(INFILE);
}elsif($opt eq "-l"){
        #Language <name>:
        #Total number of locales: <total number of locales in that language (possibly 0)>
        #Total number of charmaps: <total number of charmaps in that language (possibly 0)>
        $lang = $ARGV[1];
        scanFile("locale");
        $langLocalesNum = calculate($lang);
        #print "$langLocalesNum\n";

        scanFile("charmap");
        $langCharmapsNum = calculate($lang);
        #print "$langCharmapsNum\n";

        if($langLocalesNum == 0 && $langCharmapsNum == 0){
                print "No locales or charmaps in this language\n";
        }else{
                print "Total number of locales: $langLocalesNum\n";
                print "Total number of charmaps: $langCharmapsNum\n";
        }
	close(INFILE);
}elsif($opt eq "-v"){
        print "Student Name: Lingying Yang, Student ID: 12776136\n";
}else{
        print "Invalid command syntax\n";
}

sub scanFile{
        @typeAry = ();
        @languageAry = ();
        @filenameAry = ();
        @sizeAry = ();
        $file = $ARGV[$#ARGV];

        #verify the input file.
        (-r $file) or die "Filepath not found!";
        (-f $file) or die "It is not a file!";
        (-r $file) or die "The file is not readable!";

        open(INFILE,$file) or die "Error message: $!";

        $i = 0;
        while(<INFILE>){
                if(/^$_[0]/){
                        ($typeAry[$i],$languageAry[$i],$filenameAry[$i],$sizeAry[$i]) = split(/,/);
                        $i++;
                }
        }
}

sub printResult{
        if(scalar(@filenameAry) > 0){
                foreach $filename(@filenameAry){
                        print "$filename\n";
                }
        }else{
                print "No $_[0]s available\n";
        }
}

sub calculate{
        my $total = 0;
        foreach $language(@languageAry){
                if($language =~ m/$_[0]/){
                        $total++;
                }
        }
        return $total;
}
