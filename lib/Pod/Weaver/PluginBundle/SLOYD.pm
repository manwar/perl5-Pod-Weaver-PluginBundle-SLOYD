package Pod::Weaver::PluginBundle::SLOYD;

# ABSTRACT: SLOYD's default Pod::Weaver configuration

use strict;
use warnings;

# VERSION

=head1 OVERVIEW

It is nearly equivalent to the following:

    [@CorePrep]

    [-SingleEncoding]
    [Name]
    [Version]
    [Region  / prelude]
    [Generic / SYNOPSIS]
    [Generic / DESCRIPTION]
    [Generic / OVERVIEW]
    [Collect / ATTRIBUTES]
    command = attr
    [Collect / CLASS METHODS]
    command = classmethod
    [Collect / METHODS]
    command = method
    [Collect / FUNCTIONS]
    command = func
    [Leftovers]
    [Region  / postlude]
    [Authors]
    [Legal]

    [-Transformer / Lists]
    transformer = List
    [-Include]
    pod_path = lib:bin:docs/pod
    insert_errors = 1
    
=cut

use namespace::autoclean;

use Pod::Weaver::Config::Assembler;
sub _exp { Pod::Weaver::Config::Assembler->expand_package( $_[0] ) }

sub mvp_bundle_config {
    my @plugins = (
        [ '@Default/CorePrep',       _exp('@CorePrep'),       {} ],
        [ '@Default/SingleEncoding', _exp('-SingleEncoding'), {} ],
        [ '@Default/Name',           _exp('Name'),            {} ],
        [ '@Default/Version',        _exp('Version'),         {} ],

        [ '@Default/prelude', _exp('Region'),  { region_name => 'prelude' } ],
        [ 'SYNOPSIS',         _exp('Generic'), {} ],
        [ 'DESCRIPTION',      _exp('Generic'), {} ],
        [ 'OVERVIEW',         _exp('Generic'), {} ],

        [ 'ATTRIBUTES',    _exp('Collect'), { command => 'attr' } ],
        [ 'CLASS METHODS', _exp('Collect'), { command => 'classmethod' } ],
        [ 'METHODS',       _exp('Collect'), { command => 'method' } ],
        [ 'FUNCTIONS',     _exp('Collect'), { command => 'func' } ],

        [ '@Default/Leftovers', _exp('Leftovers'), {} ],

        [ '@Default/postlude', _exp('Region'), { region_name => 'postlude' } ],

        [ '@Default/Authors', _exp('Authors'), {} ],
        [ '@Default/Legal',   _exp('Legal'),   {} ],
    );

    push @plugins,
      (
        [ '@SLOYD/List', _exp('-Transformer'), { transformer => 'List' } ],
        [
            '@SLOYD/Include',
            _exp('-Include'),
            {
                pod_path      => "lib:bin:docs/pod",
                insert_errors => 1
            }
        ],
      );

    return @plugins;
}

1;
