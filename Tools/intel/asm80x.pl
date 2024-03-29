# asmx.pl
# a pre processor for asm80 files providing support for names > 6 chars
# additionally $ and _ are allowed in names but ignored

my %namemap;                                # saves name map information for long names
my $maxName = 6;                            # maximum name width, is used to re-layout symbol table

die "usage: asm80x.pl file.asmx [asm80 options]\n" if $#ARGV < 0;
local $file = shift @ARGV;

open($in, "<", $file) or die "can't open $file\n";
local ($ofile, $oext) = ($file =~ /^(.*?)(?:\.([^\.]*))?$/);
$oext = ($oext eq "asmx") ? "asm" : "asx"; 
open ($out, ">$ofile.$oext") or die "can't create $ofile.$oext\n";

@prog = <$in>;                              # slup in whole program
chomp @prog;                                # don't want the new lines

# pass 1 of the pre-processor
# handles include files


sub include {
    my $file = $_[0];
    my $root = "./";
    $file =~ s/\s*(.*?)\s*$/\1/;
    if ($file =~ s/^:F(\d)://i) { # isis file
        if (!defined($ENV{"ISIS_F$1"})) {
            if ($1 ne 0) {  # let F0 default to current drive
                print "Warning :$1: not defined. Letting ASM80 process\n";
                return;
            }
        } else {
            $root = $ENV{"ISIS_F$1"};
            $root =~ s/([^\/\\])$/\1\//;
        }
        $file = $root . $file;
    }
    if (! -e $file) {
        print "Warning $file does not exist\n";
        return;
    }
    open (my $inc, "<", $file) or die "oops cannot open $file\n";
    my @inc = <$inc>;
    close $inc;
    chomp @inc;                                 # don't want the newlines
    push @inc, ";- " . $prog[$curLine];         # mark end of include
    $prog[$curLine] = ";+ " . $prog[$curLine];   # mark start of include
    splice @prog, $curLine + 1, 0, @inc;         # insert the include file
}


# look for include options and put them at the front of the main code
$inc = 0;
foreach (grep(/^include\s*\(/i, @ARGV)) {
        splice(@prog, $inc++, 0, "\$$_\n");
        $_ = "";
}


# map a long name to an autogenerated name of format @nnnnn
# but note only the first case insensitive name is stored in its original form
# so on post processing all the same mapped names will have the same case as the first
#
# the following global is used to make sure that if one of the macro related
# identifiers is seen then the rest of the line is passed through unprocessed
my %reserved = (macro => 1, irp => 1, irpc => 1);
my $nosub = 0;
sub mapname {
    my $origName = $_[0];
    $nosub = 1 if defined($reserved{lc($origName)});
    return $origName if $nosub || $origName eq '_' || (length($origName) <= 6 && $origName !~ /[_\$]/ && $origName !~ /^\@\d{5}$/);

    my $name = uc($origName);           # make upper case
    $name =~ tr/?0-9\@A-Z//cd;          # remove illegal chars
    my $name = substr($name, 0, 31);    # truncate to 31 chars
    if (!defined($namemap{$name})) {
        $nameLookup[$mappedId] = $origName;
        $safeName[$mappedId] = $name;
        $namemap{$name} = sprintf "@%05d", $mappedId++;
        $maxName = length($name) if $maxName < length($name);
    }
    return $namemap{$name};             # return mapping
}

#
# process the whole program
#
for ($curLine = 0; $curLine <= $#prog; $curLine++) {
    if ($prog[$curLine] =~ /^\$/) {
        include($1) if $prog[$curLine] =~ /^\$\s*include\s*\(([^\)]+)\)/i;
        print $out $prog[$curLine], "\n";
        next;
    }
        
    my($line, $comment) = ($prog[$curLine] =~ /^((?:[^;']|'[^']*')*)(;.*)?/);  # split off comment
    my ($fixup, $expand);

    my @parts = split /('.*?')/, $line;            # split into string fragments and other
    $nosub = 0;                                    # allow substitution
    for my $p (@parts) {
        next if $p =~ /^'/;                        # don't convert string fragments
        $p =~ s/([\w\?\@][\w\?\@\$]*)/ mapname($1) /ieg;   # see if names need mapping
    }
    $line = join("", @parts);                       # put the line back together
    print $out join("", @parts, $comment, "\n");    # generate asm line
}


close $out;
close $in;


# now run the assembler
$lst = "$ofile.lst";
foreach (grep(/print\s*\(/i, @ARGV)) {
    /\(\s*(.*?)\s*\)/;
    $lst = $1;
    last;
}

unlink $lst;        # delete old listing file
local $objfile = "$ofile.obj";  # assume default .obj file
# check for object(file) in the command line
my @objargs = grep(/object\(/i, @ARGV);
$objfile = $1 if $objargs[0] =~ /\(\s*([^\s\)]*)/;
unlink $objfile;

my $ROOT = $ENV{ITOOLS} || $ENV{_ITOOLS};
my @args = ("-m", "$ROOT/itools/asm80/4.1/asm80", "$ofile.$oext", @ARGV);
my $result = system("$ROOT/thames.exe", @args);

unlink "$ofile.$oext";      # remove the temporary asm file

# convert translated names back to original names
# for the symbols use the safe name and re-layout the table for wider symbols
#
if (-e $lst) {
    open($in, "<", $lst) or die "can't open $lst\n";
    open ($out, ">$ofile.$$") or die "can't create $ofile.$$\n";

    my $syms = 0;
    my $symLineLen = 0;
    while (<$in>) {
        $syms++ if /^(PUBLIC|EXTERNAL|USER) SYMBOLS/;           # look for symbol table reformat
        if (/^\s*$/ && $symLineLen) {
            print $out "\n";
            $symLineLen = 0;
        }
        if ($syms) {
            s/\@(\d{5})/ $safeName[$1]/eg;
            if (/^[\w\?\@\.\$]+\s+[A-Z] [0-9A-F]{4}/) {    # reformat using wider symbol name
                my @item = split;
                for (my $i = 0; $i < $#item; $i += 3) {
                    if ($symLineLen + $maxName > 113) {
                        $symLineLen = 0;
                        print $out "\n";
                    } elsif ($symLineLen) {
                        print $out "   ";
                    }
                    printf $out "%-*s %s %s", $maxName, $item[$i], $item[$i + 1], $item[$i + 2];
                    $symLineLen += $maxName + 10;
                }
            } else {
                print $out $_;
            }
        } else {
            s/\@(\d{5})/ $nameLookup[$1]/eg;
            print $out $_;
        }
    }
    close $in;
    close $out;
    unlink $lst;                                        # remove asm generated .lst file
    unlink "$ofile.asm";                                        # remove intermediate .asm file
    rename "$ofile.$$", $lst;                            # replace with updated .lst file
}

# check for obj file and update names in public, extern, and locals definitions
# commons are not checked because ASM doesn't support them
# note like PLM $ and _ are removed and names are converted to upper case
sub mkRecord {
    my($type, $rec) = @_;
    $rec = pack("Cva*", $type, length($rec) + 1, $rec);
    return $rec . chr((256 - unpack("%8C*", $rec)) & 0xff);
}

sub mkObjName {
    my $name = uc($_[0]);
    $name =~ s/^\@(\d{5})$/ $safeName[$1]/e;
    return pack("Ca*", length($name), $name);
}
    
sub renameOne {     # no need to check length as header and ancestor records are short
    my ($name, $rest) = unpack("C/A*a*", $_[1]);
    return mkRecord($_[0], mkObjName($name) . $rest);
}


sub renameExt {
    my $data = $_[1];
    my $rec = "";
    my $name;
    while ($data ne "") {
        ($name, $data) = unpack("C/A*xa*", $data);
        my $newName = pack("a*x", mkObjName($name));
        if (length($rec) + length($newName) > 1020) {
            print $out $rec;
            $rec = "";
        }
        $rec .= $newName;
    }
    return mkRecord($_[0], $rec);
}

sub renamePubLocal {
    my ($seg, $data) = unpack("aa*", $_[1]);       # split of segId
    my $rec = $seg;
    my ($offset, $name);
    while ($data ne "") {
        ($offset, $name, $data) = unpack("vC/A*xa*", $data);
        my $newName = pack("va*x", $offset, mkObjName($name));
        if (length($rec) + length($newName) > 1020) {
            print $out $rec;
            $rec = $seg;
        }
        $rec .= $newName;
    }
    return mkRecord($_[0], $rec);
}

sub getRecord {
    my ($hdr, $type, $len, $data);
    $type = $data = "";
    if (read($in, $hdr, 3) != 3) {
        print "premature eof\n";
    } else { 
        ($type, $len) = unpack("Cv", $hdr);
        if (read($in, $data, $len) != $len) {
            print "premature eof\n";
            $type = "";
        } elsif (unpack("%8C*", $hdr . $data) != 0) {
            print "crc error\n";
        } else {
            chop $data;         # remove the crc
        }
    }
    return ($type, $data);
}

if (-e "$objfile") {
    open($in, "<:raw", "$objfile") or die "can't open $objfile\n";
    open ($out, ">:raw", "$ofile.$$") or die "can't create $ofile.$$\n";

    while (1) {
        my ($type, $data) = getRecord();
        last if ($type eq "");          # past eof
        my $rec;

        if ($type == 2 || $type == 0x10) {      # MODHDR or ANCESTOR
            $rec = renameOne($type, $data);
        } elsif ($type == 0x16 || $type == 0x12) { # PUBLIC or LOCAL
            $rec = renamePubLocal($type, $data);
        } elsif ($type == 0x18) {               # EXTERNAL
            $rec = renameExt($type, $data);
        } else {
            $rec = mkRecord($type, $data);  # recreate the original record
        }
        print $out $rec;
        last if $type == 0xE;        # end of file record seen
    }

    close $in;
    close $out;
    unlink "$objfile";
    rename "$ofile.$$", "$objfile";
}

$result;        # let make or whatever aware of the asm result
