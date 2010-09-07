package Acme::Teddy;
# For we doeth darke magiks.
#use strict;
#use warnings;

#~ use Devel::Comments;

our $VERSION    = 1.002003;

sub import {
    my $callpkg     = caller(1);
    my $pkg         = shift;
    my @imports     = @_;       # anything you like, baby
    my $type        ;
    my $sym         ;
    
    ### $callpkg
    ### $pkg
    ### @imports
    
    # Ripped from Exporter::Heavy::heavy_export()
    foreach $sym (@imports) {
    # shortcut for the common case of no type character
    (*{"${callpkg}::$sym"} = \&{"${pkg}::$sym"}, next)
        unless $sym =~ s/^(\W)//;
    $type = $1;
    *{"${callpkg}::$sym"} =
        $type eq '&' ? \&{"${pkg}::$sym"} :
        $type eq '$' ? \${"${pkg}::$sym"} :
        $type eq '@' ? \@{"${pkg}::$sym"} :
        $type eq '%' ? \%{"${pkg}::$sym"} :
        $type eq '*' ?  *{"${pkg}::$sym"} :
        die "$pkg: Can't export symbol: $type$sym\n";
    }
};

## END MODULE
1;
#============================================================================#
__END__

=head1 NAME

Acme::Teddy - Dummy target for your pitbull testing module

=head1 VERSION

This document describes Acme::Teddy version 1.23

=head1 SYNOPSIS
    
    # teddytest.t
    {
        package Acme::Teddy;
        sub chewtoy{ 'Squeek!' };
        our $yogi   = 'bear';
    }
    package main;
    use Acme::Teddy qw( chewtoy $yogi );
    use Test::More tests => 2;
    is( chewtoy(),  'Squeek!',          'teddy-squeek'  );
    is( $yogi,      'bear',             'teddy-bear'    );

    # teddytest-oo.t
    {
        package Acme::Teddy;
        sub new{ return bless {} };
        sub talk{ 'Yabba dabba do!' };
    }
    package main;
    use Acme::Teddy;
    use Test::More tests => 1;
    my $bear    = Acme::Teddy::new();
    my $talk    = $bear->talk();
    is( $talk,      'Yabba dabba do!',  'teddy-oo-talk'    );

=head1 DESCRIPTION

Testing modules need something to test. 
Acme::Teddy is all things to all bears. 

The code shown in L<SYNOPSIS> is all in one file. 
Switch into C<package Acme::Teddy> in your test script, define whatever you 
like there. Then switch back to C<package main> and test your testing module. 

=head1 METHODS

=head2 import()

This is a cut-down copy of L<Exporter::Heavy>::heavy_export() 
(the same routine that B<Exporter> uses normally to export stuff on request). 

There are two reasons we don't say C<@ISA = qw(Exporter);>. We don't want to 
introduce any dependencies whatsoever; and we offer caller the freedom to 
export anything at all. Almost no checking is done of arguments passed 
to C<import()> (normally, on the C<use()> line).

=head1 INTERFACE 

Import whatever you like when you C<use Acme::Teddy>. 
Be sure to define it, whatever it is. 
AT will attempt to export to caller I<everything> you request. 

You don't have to import anything. 
You can invoke a function (that you defined) with: 

    my $return  = Acme::Teddy::my_button_nose();

Or invoke a method: 

    my $bear    = Acme::Teddy::new();
    $bear->talk();

Don't forget to define those methods! 

=head1 DIAGNOSTICS

=over

=item $pkg: Can't export symbol: $type$sym

You tried to import something bizarre. Check your C<use()> line. 

Rationally, you can only export I<symbols> from one package to another. 
These can be barewords, which will be interpreted as subroutines; 
scalar, array, or hash variables; coderefs; or typeglobs. 

=back 

=head1 CONFIGURATION AND ENVIRONMENT

Acme::Teddy requires no configuration files or environment variables.

=head1 DEPENDENCIES

No dependencies. 

=head1 INCOMPATIBILITIES

None.

=head1 BUGS AND LIMITATIONS

You really do have to define stuff yourself or it does nothing. 

Lexical variables aren't found in package symbol tables. 

=head1 THANKS

=over

=item *

B<james2vegas> of L<PerlMonks|http://perlmonks.org/> 
for improvements in the test script. 

=back

=head1 AUTHOR

Xiong Changnian  C<< <xiong@cpan.org> >>

=head1 LICENSE

Copyright (C) 2010 Xiong Changnian C<< <xiong@cpan.org> >>

This library and its contents are released under Artistic License 2.0:

L<http://www.opensource.org/licenses/artistic-license-2.0.php>

=cut
