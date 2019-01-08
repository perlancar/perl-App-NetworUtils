package App::NetworkUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Exporter::Rinci qw(import);
use File::Which qw(which);
use IPC::System::Options 'system', 'readpipe', -log=>1;

our %SPEC;

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Command-line utilities related to networking',
};

$SPEC{'turn_on_networking'} = {
    v => 1.1,
    summary => 'Turn on networking',
    description => <<'_',

Will try:
- nmcli

_
};
sub turn_on_networking {
    my %args = @_;

  NMCLI:
    {
        unless (which("nmcli")) {
            log_trace "Cannot find nmcli, skipping using nmcli";
            last;
        }
        log_trace "Using nmcli to turn networking on";
        system "nmcli", "networking", "on";
        unless ($?) {
            return [200, "OK", undef, {'func.method'=>'nmcli'}];
        }
    }
    [500, "Failed, no methods succeeded"];
}

$SPEC{'turn_off_networking'} = {
    v => 1.1,
    summary => 'Turn off networking',
    description => <<'_',

Will try:
- nmcli

_
};
sub turn_off_networking {
    my %args = @_;

  NMCLI:
    {
        unless (which("nmcli")) {
            log_trace "Cannot find nmcli, skipping using nmcli";
            last;
        }
        log_trace "Using nmcli to turn networking off";
        system "nmcli", "networking", "off";
        unless ($?) {
            return [200, "OK", undef, {'func.method'=>'nmcli'}];
        }
    }
    [500, "Failed, no methods succeeded"];
}

$SPEC{'turn_on_wireless'} = {
    v => 1.1,
    summary => 'Turn on wireless networking',
    description => <<'_',

Will try:
- nmcli

_
};
sub turn_on_wireless {
    my %args = @_;

  NMCLI:
    {
        unless (which("nmcli")) {
            log_trace "Cannot find nmcli, skipping using nmcli";
            last;
        }
        log_trace "Using nmcli to turn wireless networking on";
        system "nmcli", "radio", "wifi", "on";
        unless ($?) {
            return [200, "OK", undef, {'func.method'=>'nmcli'}];
        }
    }
    [500, "Failed, no methods succeeded"];
}

$SPEC{'turn_off_wireless'} = {
    v => 1.1,
    summary => 'Turn off wireless networking',
    description => <<'_',

Will try:
- nmcli

_
};
sub turn_off_wireless {
    my %args = @_;

  NMCLI:
    {
        unless (which("nmcli")) {
            log_trace "Cannot find nmcli, skipping using nmcli";
            last;
        }
        log_trace "Using nmcli to turn wireless networking off";
        system "nmcli", "radio", "wifi", "off";
        unless ($?) {
            return [200, "OK", undef, {'func.method'=>'nmcli'}];
        }
    }
    [500, "Failed, no methods succeeded"];
}

$SPEC{'networking_is_on'} = {
    v => 1.1,
    summary => 'Return true when networking is on, or 0 otherwise',
    description => <<'_',

Will try:
- nmcli

_
};
sub networking_is_on {
    my %args = @_;

  NMCLI:
    {
        unless (which("nmcli")) {
            log_trace "Cannot find nmcli, skipping using nmcli";
            last;
        }
        log_trace "Using nmcli to check networking status";
        my $out;
        system {capture_stdout=>\$out}, "nmcli", "networking", "connectivity";
        last if $?;
        $out =~ s/\R//;

        if ($out =~ /none/) {
            return [200, "OK", 0, {'func.method'=>'nmcli', 'cmdline.result'=>"Networking is off ($out)", 'cmdline.exit_code'=>0}];
        } else {
            return [200, "OK", 1, {'func.method'=>'nmcli', 'cmdline.result'=>"Networking is on ($out)", 'cmdline.exit_code'=>0}];
        }
    }
    [500, "Failed, no methods succeeded"];
}

1;
# ABSTRACT:

=head1 DESCRIPTION

This distribution includes the following command-line utilities related to
networking:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<App::BluetoothUtils>
