#############################################################################
#
# Update a Perl RPM spec with the latest GA in the CPAN
#
# Author:  Chris Weyl (cpan:RSRCHBOY), <cweyl@alumni.drew.edu>
# Company: No company, personal work
# Created: 05/12/2009 09:54:18 PM PDT
#
# Copyright (c) 2009 Chris Weyl <cweyl@alumni.drew.edu>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
#############################################################################

package Fedora::App::MaintainerTools::Command::updatespec; 

use Moose;

extends 'MooseX::App::Cmd::Command'; 

use Fedora::App::MaintainerTools::UpdateData;

#use namespace::clean -except => 'meta';

our $VERSION = '0.001';

sub run {
    my ($self, $opt, $args) = @_;

    $app->log->info('Beginning updatespec run.'); 

    for my $pkg (@$args) {

        my $data = Fedora::App::MaintainerTools::UpdateData->new(
            spec  => RPM::Spec->new(specfile => "$pkg"),
            cpanp => $self->app->cpanp,
        );
        $self->app->plugin_pkg->call_plugins('perl_spec_update', $data);

        print join("\n", @{ $data->content });
    }

    return;
}


__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

Fedora::App::MaintainerTools::Command::updatespec - Update a spec to latest GA version from the CPAN

=head1 DESCRIPTION

Updates a spec file with metadata from the CPAN.


=head1 SEE ALSO

L<Fedora::App::MaintainerTools>

=head1 AUTHOR

Chris Weyl  <cweyl@alumni.drew.edu>


=head1 LICENSE AND COPYRIGHT

Copyright (c) 2009 Chris Weyl <cweyl@alumni.drew.edu>

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the 

    Free Software Foundation, Inc.
    59 Temple Place, Suite 330
    Boston, MA  02111-1307  USA

=cut



